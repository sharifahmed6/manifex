import 'package:flutter/material.dart';
import 'package:get/get.dart';

class back_button extends StatelessWidget {
  const back_button({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Get.back(),
      icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
    );
  }
}
