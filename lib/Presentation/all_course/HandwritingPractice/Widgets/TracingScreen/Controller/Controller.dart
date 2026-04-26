import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manifex/App/AppColors.dart';
import 'package:signature/signature.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;
import '../../../../../../Core/SharepreferenceHelper.dart';
import '../../../../../../Core/snakbar.dart';
import '../../../../../Share/custom_circle_progress_indicator.dart';
import '../../../Controller/Controller.dart';

class TracingController extends GetxController {
  final SignatureController signatureController = SignatureController(
    penStrokeWidth: 6,
    penColor: AppColors.sky,
    exportBackgroundColor: Colors.transparent,
  );
  var imagePath = ''.obs;
  int correctWord = 0;
  int incorrectWord = 0;


  var isLoading = false.obs;

  void clearCanvas() => signatureController.clear();

  Future<String?> saveSignaturePng({
    required SignatureController controller,
    required String fileName,
    required String word,
  }) async {
    try {
      // 1️⃣ Convert signature to image
      final ui.Image? signatureImage = await controller.toImage();
      if (signatureImage == null) return null;

      // 2️⃣ Create a white background canvas
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(
        recorder,
        Rect.fromLTWH(
          0,
          0,
          signatureImage.width.toDouble(),
          signatureImage.height.toDouble(),
        ),
      );

      // Paint white background
      final paint = Paint()..color = Colors.white;
      canvas.drawRect(
        Rect.fromLTWH(
          0,
          0,
          signatureImage.width.toDouble(),
          signatureImage.height.toDouble(),
        ),
        paint,
      );

      // Draw the signature on top
      canvas.drawImage(signatureImage, Offset.zero, Paint());

      // 3️⃣ Convert canvas to PNG bytes
      final picture = recorder.endRecording();
      final img = await picture.toImage(
        signatureImage.width,
        signatureImage.height,
      );
      final byteData = await img.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) return null;

      // 4️⃣ Save to file
      final directory = await getApplicationDocumentsDirectory();
      // Use a timestamp to avoid case-sensitivity issues (A vs a) and path conflicts
      final uniqueFileName = '${fileName}_${DateTime.now().millisecondsSinceEpoch}.png';
      final file = File('${directory.path}/$uniqueFileName');
      
      await file.writeAsBytes(byteData.buffer.asUint8List(), flush: true);

      return file.path;
    } catch (e) {
      print("Error saving signature with white background: $e");
      return null;
    }

  }

  Future<bool> submit({required String imagePath, required String word}) async {
    print("Word is $word");
    final url = Uri.parse(
      "https://ai.manifex.org/api/v1/handwriting/check_handwriting",
    );

    isLoading.value = true;
    try {
      final request = http.MultipartRequest('POST', url);

      // ✅ Correct header
      request.headers['authtoken'] = PrefHelper.getAccessToken();

      // ✅ Add image
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          imagePath,
          contentType: http.MediaType('image', 'png'),
        ),
      );

      // ✅ Add word normally
      request.fields['word'] = word;

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      final finalResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if(finalResponse['correct']){
          correctWord++;
          AppSnackbar.show("Correct! Great job.");
        }else{
          incorrectWord++;
          AppSnackbar.show("Please try again to perfect your stroke.");
        }


        if(word ==  'F' || word ==  'L' || word ==  'R' || word ==  'Z' || word ==  'f' || word ==  'l' || word ==  'r' || word ==  'z' || word ==  '9') {

          final total = correctWord + incorrectWord;
          double percentage = 0;
          if (total > 0) {
            percentage = (correctWord / total) * 100;
            correctWord = 0;
            incorrectWord = 0;
          }
          final controller = Get.find<HandwritingPracticeController>();
          
          // Use safe index access to avoid RangeError
          int taskIndex = -1;
          if (word == 'F' || word == 'L' || word == 'R' || word == 'Z') {
            taskIndex = 0; // Cursive Task
          } else if (word == 'f' || word == 'l' || word == 'r' || word == 'z') {
            taskIndex = 1; // Print Task
          } else if (word == '9') {
            taskIndex = 2; // Numbers Task
          }

          if (taskIndex != -1 && taskIndex < controller.result.length) {
            controller.result[taskIndex]['marks'] = percentage;
            if (taskIndex == 2) {
              controller.FinalSubmission();
            }
          }
        }
        
        isLoading.value = false;
        
        // Cleanup: delete the temporary image file after submission
        try {
          final file = File(imagePath);
          if (await file.exists()) {
            await file.delete();
          }
        } catch (e) {
          print("Error deleting temporary file: $e");
        }
        
        return finalResponse['correct'] ?? false;
      } else {
        AppSnackbar.show("Server error. Please try again.");
        isLoading.value = false;
        return false;
      }
    } catch (e) {
      print("Error: $e");
      AppSnackbar.show("Connection error. Please try again.");
      isLoading.value = false;
      return false;
    }
  }

}
