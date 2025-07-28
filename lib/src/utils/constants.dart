// lib/src/utils/constants.dart
class AppConstants {
  static const String baseUrl = 'https://jodiethomas729.vercel.app/api/v1';
  static const String appName = 'SoberForThem';
  static const String version = '1.0.0';
}

class HiveBoxes {
  static const String userBox = 'user_box';
  static const String taskBox = 'task_box';
  static const String settingsBox = 'settings_box';
}

class ApiEndpoints {
  // Auth
  static const String login = '/auth/login';
  static const String register = '/users/register';
  static const String forgotPassword = '/users/forgot-password';
  static const String resendOtp = '/users/resend-otp';
  static const String verifyOtp = '/users/verify-otp';
  static const String verifyOtpForgotPassword =
      '/users/verify-otp-forgot-password';
  static const String updatePassword = '/users/update-password';
  static const String changePassword = '/users/change-password';
  static const String profile = '/users/me';
  static const String updateProfile = '/users/update-profile';
  static const String updateProfileImage = '/users/update-profile-image';
}
