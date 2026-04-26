import 'dart:convert';
import 'package:get/get.dart';
import 'package:manifex/Core/MusicService.dart';
import 'package:http/http.dart' as http;
import '../../../../../../Core/SharepreferenceHelper.dart';
import '../../../../../../Core/snakbar.dart';

class WritingTaskController extends GetxController {
  var words = <String>[].obs;
  var isLoading = false.obs;
  var currentIndex = 0.obs;
  var isStepTwo = false.obs; // false = Step 1 (Watermark), true = Step 2 (Independent)

  @override
  void onInit() {
    super.onInit();
    // Music is handled by FreeWritingController
  }

  Future<void> fetchWords() async {
    final userId = PrefHelper.getUserId().toString();
    final url = Uri.parse("https://ai.manifex.org/api/v1/handwriting/get_handwriting_words?user_id=$userId");
    
    try {
      isLoading.value = true;
      final response = await http.post(url, headers: {'authtoken': '1'});
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        words.assignAll(List<String>.from(data['words']));
      } else {
        print("Error fetching words: ${response.statusCode}");
        AppSnackbar.show("Error fetching words.");
      }
    } catch (e) {
      print("Error fetching words: $e");
      AppSnackbar.show("Connection error.");
    } finally {
      isLoading.value = false;
    }
  }

  void reset() {
    currentIndex.value = 0;
    isStepTwo.value = false;
  }
}
