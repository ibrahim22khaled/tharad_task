
class ApiConstants {
  const ApiConstants._();

  static const String apiBaseUrl = "https://flutter.tharadtech.com/api/";

  static String addBaseUrl(String url) => "$apiBaseUrl$url";
  static String apiKey = "";
  // Authentication
  static String loginUrl = ApiConstants.addBaseUrl("auth/login");
  static String registerUrl = ApiConstants.addBaseUrl("auth/register");
  static String otpUrl = ApiConstants.addBaseUrl("otp");
  //Profile
  static String getProfileUrl = ApiConstants.addBaseUrl("profile-details");
  static String updateProfileUrl = ApiConstants.addBaseUrl("Update-Profile");
}