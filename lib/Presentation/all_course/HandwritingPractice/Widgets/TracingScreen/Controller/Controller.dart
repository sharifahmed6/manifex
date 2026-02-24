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
      final file = File('${directory.path}/$fileName.png');
      await file.writeAsBytes(byteData.buffer.asUint8List());

      return file.path;
    } catch (e) {
      print("Error saving signature with white background: $e");
      return null;
    }

  }

  Future<void> submit({required String imagePath, required String word}) async {
    print("Word is $word");
    final url = Uri.parse(
      "https://ai.manifex.org/api/v1/handwriting/check_handwriting",
    );

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

      Get.dialog(
        barrierDismissible: false,
        const CustomCircleProgressIndicator(),
      );

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      Get.back();

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      final finalResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if(finalResponse['correct']){
          correctWord++;
          AppSnackbar.show("Correct Word");
        }else{
          incorrectWord++;
          AppSnackbar.show("Incorrect Word");
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
          word == 'F' ? controller.result[0]['marks'] = percentage :
          word == 'L' ? controller.result[1]['marks'] = percentage :
          word == 'R' ? controller.result[2]['marks'] = percentage :
          word == 'Z' ? controller.result[3]['marks'] = percentage :
          word == 'f' ? controller.result[4]['marks'] = percentage :
          word == 'l' ? controller.result[5]['marks'] = percentage :
          word == 'r' ? controller.result[6]['marks'] = percentage :
          word == 'z' ? controller.result[7]['marks'] = percentage :
          word == '9' ? {
            controller.result[8]['marks'] = percentage,
            controller.FinalSubmission()
          } : null;

          print("${controller.result}");


          print("Total words: ${correctWord+incorrectWord} Correct Words: $correctWord Incorrect Word: $incorrectWord");
        }

      } else {
        AppSnackbar.show("Something went wrong.");
      }
    } catch (e) {
      Get.back();
      print("Error: $e");
    }
  }
}
