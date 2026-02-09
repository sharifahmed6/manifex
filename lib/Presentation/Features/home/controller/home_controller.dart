import 'package:get/get.dart';
import 'package:manifex/App/Urls.dart';
import 'package:manifex/App/network_caller.dart';
import 'package:manifex/Presentation/Features/home/model/user_model.dart';

class HomeController extends GetxController {
  final profileInfo = Rxn<UserModel>();
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfileInfo();
  }

  String get userId => profileInfo.value?.data?.id ?? '';
  String get ageRange => profileInfo.value?.data?.age ?? '';
  int get apiAge => _mapAgeToApi(ageRange);
  bool get isReady => userId.isNotEmpty;

  Future<void> fetchProfileInfo() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await NetworkCaller().getRequest(
        url: urls.profileInfo,
      );

      if (response.isSuccess && response.responseData != null) {
        profileInfo.value = UserModel.fromJson(response.responseData!);
      } else {
        errorMessage.value = response.errorMessage;
      }
    } catch (e) {
      errorMessage.value = 'Something went wrong';
    } finally {
      isLoading.value = false;
    }
  }

  int _mapAgeToApi(String? range) {
    final s = (range ?? '').trim();

    if (s == '6-9') return 8;
    if (s == '10-13') return 12;
    if (s == '14-17') return 16;
    if (s == '18-40') return 39;

    final parts = s.split('-').map((e) => e.trim()).toList();
    if (parts.length == 2) {
      final a = int.tryParse(parts[0]);
      final b = int.tryParse(parts[1]);
      if (a != null && b != null) return ((a + b) / 2).round();
    }

    final single = int.tryParse(s);
    if (single != null) return single;

    return 12;
  }
}
