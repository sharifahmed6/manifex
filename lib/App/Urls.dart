class urls {
   static String baseUrl = "https://api.manifex.org/api/v1";
  ///// ai api
   static String aiBaseUrl = "https://ai.manifex.org/api/v1/";
   static String phonemeFlashcard(String age,String userId) => "${aiBaseUrl}reading/phoneme-flashcards/generate_phoneme_flashcards?age=$age&user_id=$userId";
   static String sighWordPractice(String userId) => "${aiBaseUrl}reading/sight-word-practice/sight_words?user_id=$userId";
   static String aiQuestion(String age) => "${aiBaseUrl}reading/comprehension/generate_comprehension?age=$age";
  static String createOne = "$baseUrl/auth/register-user";
  static String resendOtp = "$baseUrl/auth/register-user";
  static String userVerify = "$baseUrl/auth/verify-otp";
  static String login = "$baseUrl/auth/login";
  static String forgetPassword = "$baseUrl/auth/forgot-password";
  static String verifyRestPasswordOtp = "$baseUrl/auth/verify-reset-password-otp";
  static String restPassword = "$baseUrl/auth/reset-password";



  static String getFlowChain = "$baseUrl/presentation/flow-chain/get_flow_chain?user_id=test";
  static String flowChainScore = "$baseUrl/presentation/flow-chain/flow_chain";
  static String getPowerWords = "https://ai.manifex.org/api/v1/presentation/power-words/get_power_words";
  static String powerWordsScore= "$baseUrl/presentation/power-words/power_words";

   ///  backend api
static String match_word = "$baseUrl/word-match";
}