import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manifex/App/AppColors.dart';
import 'package:signature/signature.dart';
import 'dart:typed_data';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import '../../../../../../Core/SharepreferenceHelper.dart';
import '../../../../../Share/custom_circle_progress_indicator.dart';
class TracingController extends GetxController {
  final SignatureController signatureController = SignatureController(
    penStrokeWidth: 6,
    penColor: AppColors.sky,
    exportBackgroundColor: Colors.transparent,
  );

  void clearCanvas() => signatureController.clear();

  Future<String?> saveSignaturePng({required SignatureController controller, required String fileName, required String word}) async {
    try {
      // 1️⃣ Get PNG bytes
      Uint8List? pngBytes = await controller.toPngBytes();

      if (pngBytes == null) return null;

      // 2️⃣ Get app document directory
      final directory = await getApplicationDocumentsDirectory();

      // 3️⃣ Create file path
      final file = File('${directory.path}/$fileName.png');

      // 4️⃣ Write bytes to file
      await file.writeAsBytes(pngBytes);

      // 5️⃣ Return file path
      return file.path;
    } catch (e) {
      print("Error saving signature: $e");
      return null;
    }
  }

  Future<void> submit({
    required String imagePath,
    required String word,
  }) async {
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

    } catch (e) {
      Get.back();
      print("Error: $e");
    }
  }



}