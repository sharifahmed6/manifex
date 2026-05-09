import 'dart:async';
import 'package:get/get.dart';
import 'package:manifex/App/network_caller.dart';
import 'package:manifex/Core/loading.dart';
import '../../../../App/Urls.dart';

class presentationPracticeController extends GetxController {
  var selectedIndex = 0.obs;
  void changeTab(int index) => selectedIndex.value = index;
  var listLock = [false,true,true,true].obs;
  var listComplete = [true, true, true, true].obs;
  var finalResult = [];


  Future<void> unlocktask(int index) async {
    if(index != listLock.length){
      listLock[index] = false;
    }
    listComplete[index-1] = false;
  }

  void showFinalResult() {
    print("Final Result Length: ${finalResult.length}");
    print("Final Result: $finalResult");
  }

  Future<void> submitFinalAnswers() async {
    AppLoader.show();

    try {
      NetworkResponse response = await NetworkCaller().postRequest(
        url: urls.presentationSubmit,
        body: {"tasks": finalResult},
      );
      AppLoader.hide();

      if (response.statusCode == 201 &&
          response.responseData != null &&
          response.responseData?['success'] == true) {
        listComplete[3] = false;
      } else {
        print("Error submitting final answers ❌");
        print("Server message: ${response.responseData?['message'] ?? response.errorMessage}");
      }
    } catch (e) {
      AppLoader.hide();
      print("HTTP Error: $e");
    }
  }

  RxInt seconds = 0.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      seconds.value++;
    });
  }

  String get formattedTime {
    final h = (seconds.value ~/ 3600).toString().padLeft(2, '0');
    final m = ((seconds.value % 3600) ~/ 60).toString().padLeft(2, '0');
    final s = (seconds.value % 60).toString().padLeft(2, '0');
    return "$h:$m:$s";
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }


}