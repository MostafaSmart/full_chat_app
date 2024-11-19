class ApiConstants {
  static const header = {'Accept': 'application/json', 'Accept-Language': 'ar'};
  // static const String baseUrl = "http://192.168.90.104:8001/api/";
  static const String baseUrl = "http://192.168.43.59:8000/api/";
  
  ///=========================================   Auth Urls ===============================================
  static const String AUTH_ENDPOINT = "auth/";
  static String LOGIN = "${AUTH_ENDPOINT}login";
  static String LOGOUT = "${AUTH_ENDPOINT}logout/";
  static String refreshToken = "${AUTH_ENDPOINT}token/refresh/";
  static String REGISTER_USER = "${AUTH_ENDPOINT}register";
  static String FORGET_PASSWORD = "${AUTH_ENDPOINT}password/forgot/";
  static String getVerify_Code = "${AUTH_ENDPOINT}moreVerify";
  static String send_verify_Code_Email = "${AUTH_ENDPOINT}verify";
  static String restPassword = "${AUTH_ENDPOINT}password/reset/";
  ///=========================================   messeges Urls ===============================================
  static const String Messeges_ENDPOINT = "messeges/";
  static String CREATE_Messege = "${Messeges_ENDPOINT}send";
  static String UPDATE_POST = "${Messeges_ENDPOINT}update/";
  static String DELEATE_POST = "${Messeges_ENDPOINT}delete/";
  static String GET_POSTUser = "${Messeges_ENDPOINT}user/";
  static String LIKE_POST = "${Messeges_ENDPOINT}like/";
  ///=========================================  Dig Urls ===============================================
  static const String DIAGNOSIS = "diagnosis/";
  static const String REPORTS = "${DIAGNOSIS}reports/";
  ///=========================================  Disease Urls ===============================================
  static const String Disease = "diseases/";
  static const String Search_Disease = "${Disease}search/";
  ///======================================== Doctor Urls ===============================================
  static const String DOCTOR = "doctors/";
  static const String CITIES = "users/cities/";

  ///========================================= Researches Urls ===============================================
  static const String RESEARCHES_ENDPOINT = "researches/";
  static String Field = "${RESEARCHES_ENDPOINT}fields/";
  static String Journal = "${RESEARCHES_ENDPOINT}journals/";

  ///========================================= Advertisement Urls ===============================================
  static String ADVERTISEMENT = "advertisements/";
  static String click = "${ADVERTISEMENT}click/";

  ///========================================= Consultation Urls ===============================================

  static const String CONSULTATION_ENDPOINT = "consultations/";
  static const String SEND = "${CONSULTATION_ENDPOINT}send/";
  // static const String CONSULTATION = "${CHAT_ENDPOINT}conversations/";

  //============================================== Rating Urls=================================================
  static String EVALUATIONS_ENDPOINT = "evaluations/";
  static String SEND_EVALUATIONS = "${EVALUATIONS_ENDPOINT}set/";

  ///=========================================   Profile Urls ===============================================
  static const String PROFILE_ENDPOINT = "profile/";
  static String CREATE_Profile = "${PROFILE_ENDPOINT}create/";
  static String UPDATE_PROFILE = "${PROFILE_ENDPOINT}update/";
  static String DELETE_PROFILE = "${PROFILE_ENDPOINT}delete/";
  static String GET_PROFILE = "${PROFILE_ENDPOINT}prfile/";

  ///=========================================   subscrip Urls ===============================================
  static const String SUBSCRIP_ENDPOINT = "patients/";
  static String GET_SUBSCRIP = "${SUBSCRIP_ENDPOINT}plan/";
  static String UPDET_SUBSCRIP = "${GET_SUBSCRIP}/";
}

class PusherConest {
  final PUSHER_APP_ID = '1861904';
  final PUSHER_KEY = '6c5bc3a240a5017e7aac';
  final PUSHER_SECRET = '3c8d562b800fbe10857e';
  final PUSHER_CLUSTER = 'ap1';
}
