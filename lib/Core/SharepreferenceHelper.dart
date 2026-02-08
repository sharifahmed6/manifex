import 'package:shared_preferences/shared_preferences.dart';

class PrefHelper {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  // ---------- KEYS ----------
  static const _kLoggedIn = "logged_in";
  static const _kAccessToken = "access_token";

  static const _kFirstName = "first_name";
  static const _kLastName = "last_name";
  static const _kEmail = "email";
  static const _kAge = "age";
  static const _kHobbies = "hobbies";
  static const _kProfilePic = "profile_pic";
  static const _kUserType = "user_type";
  static const _kLanguage = "language";

  static const _kIsSubscribed = "is_subscribed";
  static const _kIsSubscriptionFree = "is_subscription_free";

//------------ SAVE SUBSCRIPTIONS -----------
  static Future<void> saveSubscription({
    required bool isSubscribed,
    required bool isSubscriptionFree,
  }) async {
    await init();
    await _prefs!.setBool(_kIsSubscribed, isSubscribed);
    await _prefs!.setBool(_kIsSubscriptionFree, isSubscriptionFree);
  }

  //------------ SAVE LOGIN -------------
  static Future<void> saveLoggedIn() async {
    await init();
    await _prefs!.setBool(_kLoggedIn, true);
  }

  // ---------- SAVE ----------
  static Future<void> saveLoginData({
    required String accessToken,
    required String firstName,
    required String lastName,
    required String email,
    required String age,
    required String hobbies,
    required String profilePic,
    required String userType,
    required String language,
  }) async {
    await init();
    await _prefs!.setString(_kAccessToken, accessToken);

    await _prefs!.setString(_kFirstName, firstName);
    await _prefs!.setString(_kLastName, lastName);
    await _prefs!.setString(_kEmail, email);
    await _prefs!.setString(_kAge, age);
    await _prefs!.setString(_kHobbies, hobbies);
    await _prefs!.setString(_kProfilePic, profilePic);
    await _prefs!.setString(_kUserType, userType);
    await _prefs!.setString(_kLanguage, language);
  }

  // ---------- GET ----------
  static bool isLoggedIn() => _prefs?.getBool(_kLoggedIn) ?? false;
  static String getAccessToken() => _prefs?.getString(_kAccessToken) ?? "";

  static String getFirstName() => _prefs?.getString(_kFirstName) ?? "";
  static String getLastName() => _prefs?.getString(_kLastName) ?? "";
  static String getEmail() => _prefs?.getString(_kEmail) ?? "";
  static String getUserType() => _prefs?.getString(_kUserType) ?? "";
  static String getProfilePicture() => _prefs?.getString(_kProfilePic) ?? "";

  // ---------- LOGOUT ----------
  static Future<void> clear() async {
    await init();
    await _prefs!.clear();
  }
}
