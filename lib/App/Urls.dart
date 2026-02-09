class urls {
  static String baseUrl = "https://api.manifex.org/api/v1";
  ///// ai api
  static String aiBaseUrl = "https://ai.manifex.org/api/v1/";
  static String phonemeFlashcard(String age, String userId) => "${aiBaseUrl}reading/phoneme-flashcards/generate_phoneme_flashcards?age=$age&user_id=$userId";
  static String sighWordPractice(String userId) => "${aiBaseUrl}reading/sight-word-practice/sight_words?user_id=$userId";
  static String aiQuestion(String age) => "${aiBaseUrl}reading/comprehension/generate_comprehension?age=$age";
  static String smartWritingCategories(String age,String userId) => "${aiBaseUrl}writing/category?age=$age&user_id=$userId";
  static String relatedWord(String userId) => "${aiBaseUrl}writing/topic?user_id=$userId";
  static String smartWriting = "${aiBaseUrl}writing/final";

  ///  backend api
  static String createOne = "$baseUrl/auth/register-user";
  static String resendOtp = "$baseUrl/auth/register-user";
  static String userVerify = "$baseUrl/auth/verify-otp";
  static String login = "$baseUrl/auth/login";
  static String forgetPassword = "$baseUrl/auth/forgot-password";
  static String verifyRestPasswordOtp = "$baseUrl/auth/verify-reset-password-otp";
  static String restPassword = "$baseUrl/auth/reset-password";
  static String match_word = "$baseUrl/word-match";
  static String profileInfo = "$baseUrl/auth/me";
  static String readingTaskComplete = "$baseUrl/reading-task/submit";
  static String smartWritingDataSend = "$baseUrl/writing-Task/submit";
}
