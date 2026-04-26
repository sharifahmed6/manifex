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
import '../../../Controller/Controller.dart';

class WritingAreaController extends GetxController {
  final SignatureController signatureController = SignatureController(
    penStrokeWidth: 6,
    penColor: AppColors.sky,
    exportBackgroundColor: Colors.transparent,
  );
  
  var isLoading = false.obs;

  void clearCanvas() => signatureController.clear();

  Future<String?> saveSignaturePng({
    required String fileName,
  }) async {
    try {
      final ui.Image? signatureImage = await signatureController.toImage();
      if (signatureImage == null) return null;

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

      canvas.drawImage(signatureImage, Offset.zero, Paint());

      final picture = recorder.endRecording();
      final img = await picture.toImage(
        signatureImage.width,
        signatureImage.height,
      );
      final byteData = await img.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) return null;

      final directory = await getApplicationDocumentsDirectory();
      final uniqueFileName = '${fileName}_${DateTime.now().millisecondsSinceEpoch}.png';
      final file = File('${directory.path}/$uniqueFileName');
      
      await file.writeAsBytes(byteData.buffer.asUint8List(), flush: true);

      return file.path;
    } catch (e) {
      print("Error saving signature: $e");
      return null;
    }
  }

  Future<bool> checkWriting({
    required String imagePath,
    required String word,
  }) async {
    final url = Uri.parse("https://ai.manifex.org/api/v1/handwriting/check_handwriting_words");

    isLoading.value = true;
    try {
      final request = http.MultipartRequest('POST', url);
      request.headers['authtoken'] = '1';
      
      request.files.add(
        await http.MultipartFile.fromPath(
          'image', 
          imagePath,
          contentType: http.MediaType('image', 'png'),
        )
      );
      
      request.fields['word'] = word;

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      
      final finalResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Aligned with client feedback: check for score == 100
        int score = finalResponse['score'] ?? 0;
        bool isCorrect = score == 100;
        
        if (isCorrect) {
          AppSnackbar.show("Great job! Perfect score.");
        } else {
          AppSnackbar.show("Keep trying! Practice makes perfect.");
        }
        
        // Cleanup
        try {
          final file = File(imagePath);
          if (await file.exists()) await file.delete();
        } catch (e) {
          print("Cleanup error: $e");
        }
        
        return isCorrect;
      } else {
        AppSnackbar.show("Evaluation failed. Please try again.");
        return false;
      }
    } catch (e) {
      print("Error: $e");
      AppSnackbar.show("Connection error.");
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
