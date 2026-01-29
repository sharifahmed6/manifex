import 'package:get/get.dart';

class ToggleTabController extends GetxController{
  final selectedIndex = 0.obs;

  void changeTab(int i) => selectedIndex.value = i;
}