import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manifex/App/Urls.dart';
import 'package:manifex/App/network_caller.dart';
import 'package:manifex/Core/SharepreferenceHelper.dart';
import 'package:manifex/Presentation/Features/home/controller/home_controller.dart';

import '../model/family_members_model.dart';

class FamilyMemberAddController extends GetxController {
  final controller = Get.find<HomeController>();
  final isLoading = false.obs;
  final memberIsLoading = false.obs;
  final emailController = TextEditingController();
  final members = <Member>[].obs;
  final subscription = Rxn<Subscription>();
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final url = urls.getMemberId(controller.profileInfo.value?.data?.subscription?.id ?? '');

      final NetworkResponse response = await NetworkCaller().getRequest(url: url);

      if (response.isSuccess == true && response.responseData != null) {
        final parsed = FamilyMembersResponse.fromJson(
          response.responseData as Map<String, dynamic>,
        );

        subscription.value = parsed.data?.subscription;
        members.assignAll(parsed.data?.members ?? []);
      } else {
        errorMessage.value =
            (response.errorMessage ?? 'Failed to load members').toString();
        members.clear();
        subscription.value = null;
      }
    } catch (e) {
      errorMessage.value = 'Something went wrong';
      if (kDebugMode) {
        print('fetchData error: $e');
      }
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> memberAdd() async {
    if (members.length >= 3) {
      Get.snackbar(
        'Notice'.tr,
        'You cannot add more than 3 members.'.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    memberIsLoading.value = true;
    NetworkResponse response = await NetworkCaller().postRequest(
        url: urls.familyMemberAdd,
        body: {
          "subscriptionId": subscription.value?.id ?? '',
          "memberEmail": emailController.text,
        }
    );

    if(response.isSuccess){
      final message = response.responseData?['message'];
      Get.snackbar('Success', message,colorText: Colors.white,backgroundColor: Colors.green);
      emailController.clear();
      fetchData();
    }else{
      final message = response.errorMessage;
      Get.snackbar('Error', message,colorText: Colors.white,backgroundColor: Colors.red.shade700);
    }
    memberIsLoading.value = false;
  }
  Future<void> removeMember({required String id,required String subscriptionId})async{
    NetworkResponse response = await NetworkCaller().postRequest(
        url: urls.removeMember(id),
        body: {
          "subscriptionId": subscriptionId ?? '',
        }
    );

    if(response.isSuccess){
      final message = response.responseData?['message'];
      Get.snackbar('Success', message,colorText: Colors.white,backgroundColor: Colors.green);
      emailController.clear();
      fetchData();
    }else{
      final message = response.errorMessage;
      Get.snackbar('Error', message,colorText: Colors.white,backgroundColor: Colors.red.shade700);
    }
  }
  bool get canAddMore {
    final max = subscription.value?.maxMembers ?? 0;
    return members.length < max;
  }

  /// UI helper
  String get memberCountText {
    final current = members.length;
    final max = subscription.value?.maxMembers ?? 0;
    return max == 0 ? '$current' : '$current / $max';
  }
}