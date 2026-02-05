class urls {
  // static String baseUrl = "https://api.manifex.org/api/v1";
   static String aiBaseUrl = "https://ai.manifex.org/api/v1/";
   static String phonemeFlashcard(String age,String userId) => "${aiBaseUrl}reading/phoneme-flashcards/generate_phoneme_flashcards?age=$age&user_id=$userId";

}