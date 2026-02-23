import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:manifex/App/Urls.dart';
import 'package:manifex/App/network_caller.dart';
import 'package:manifex/Core/SharepreferenceHelper.dart';
import 'package:manifex/Presentation/Features/home/controller/home_controller.dart';

import '../model/family_members_model.dart';

class FamilyMemberAddController extends GetxController {
  final controller = Get.find<HomeController>();
  final isLoading = false.obs;

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