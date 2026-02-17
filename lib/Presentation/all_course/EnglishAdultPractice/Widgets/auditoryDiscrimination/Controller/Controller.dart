import 'package:get/get.dart';
import 'package:manifex/Core/snakbar.dart';

class auditoryDiscriminationController extends GetxController {

  var word_pairs = [
  {
  "word1": "box",
  "word2": "bog",
  "answer": "different",
  "audio_file1": "http://127.0.0.1:8061/temp_audio/word_pair_0_1066.mp3",
  "audio_file2": "http://127.0.0.1:8061/temp_audio/word_pair_1_4760.mp3"
  },
  {
  "word1": "sun",
  "word2": "son",
  "answer": "different",
  "audio_file1": "http://127.0.0.1:8061/temp_audio/word_pair_2_4582.mp3",
  "audio_file2": "http://127.0.0.1:8061/temp_audio/word_pair_3_8847.mp3"
  },
  {
  "word1": "man",
  "word2": "men",
  "answer": "different",
  "audio_file1": "http://127.0.0.1:8061/temp_audio/word_pair_4_7541.mp3",
  "audio_file2": "http://127.0.0.1:8061/temp_audio/word_pair_5_257.mp3"
  },
  {
  "word1": "bug",
  "word2": "bag",
  "answer": "different",
  "audio_file1": "http://127.0.0.1:8061/temp_audio/word_pair_6_5032.mp3",
  "audio_file2": "http://127.0.0.1:8061/temp_audio/word_pair_7_3374.mp3"
  },
  {
  "word1": "bat",
  "word2": "bat",
  "answer": "same",
  "audio_file1": "http://127.0.0.1:8061/temp_audio/word_pair_8_9667.mp3",
  "audio_file2": "http://127.0.0.1:8061/temp_audio/word_pair_8_9667.mp3"
  }
  ];

  var currentIndex = 0.obs;
  var finalAnswer = "".obs;


  void nextWord() {
    if (currentIndex.value < word_pairs.length - 1) {
      finalAnswer.value = "";
      currentIndex.value++;
    }else{
      AppSnackbar.show("No more words left.");
    }
  }

  void previousWord() {
    if (currentIndex.value > 0) {
      finalAnswer.value = "";
      currentIndex.value--;
    }else{
      AppSnackbar.show("No more words left.");
    }
  }
}

