import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:manifex/Core/snakbar.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

class HandwritingPracticeController extends GetxController {

  var selectedIndex = 0.obs;
  void changeTab(int index) => selectedIndex.value = index;

  var listLock = [false, true, true, true, true, true, true, true, true].obs;
  var listComplete = [true, true, true, true, true, true, true, true, true].obs;

  Future<void> unLockTask(int index) async {
    listLock[index] = false;
    listComplete[index - 1] = false;
    Get.back();
    AppSnackbar.show("Task $index Completed.");
  }


  Future<String?> saveSignaturePng(SignatureController controller, String fileName) async {
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

}