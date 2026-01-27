import 'package:get/get.dart';

class ProgressController extends GetxController {
  final selectedDay = '30 D'.obs;
  RxBool  lock = true.obs;
  final progressDays = ['30 D', '60 D', '90 D'];
}