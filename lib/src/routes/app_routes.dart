// lib/src/routes/app_routes.dart
import 'package:get/get.dart';

import '../presentation/bindings/calendar_binding.dart';
import '../presentation/bindings/code_verification_binding.dart';
import '../presentation/bindings/forget_password_binding.dart';
import '../presentation/bindings/home_binding.dart';
import '../presentation/bindings/login_binding.dart';
import '../presentation/bindings/profile_binding.dart';
import '../presentation/bindings/reset_password_binding.dart';
import '../presentation/bindings/signup_binding.dart';
import '../presentation/bindings/splash_binding.dart';
import '../presentation/screens/calendar_screen.dart';
import '../presentation/screens/code_verification_screen.dart';
import '../presentation/screens/forget_password_screen.dart';
import '../presentation/screens/home_screen.dart';
import '../presentation/screens/login_screen.dart';
import '../presentation/screens/onboarding_screen.dart';
import '../presentation/screens/profile_screen.dart';
import '../presentation/screens/reset_password_screen.dart';
import '../presentation/screens/signup_screen.dart';
import '../presentation/screens/splash_screen.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgetPassword = '/forget-password';
  static const String codeVerify = '/code-verify';
  static const String resetPassword = '/reset-password';
  static const String home = '/home';
  static const String calendar = '/calendar';
  static const String profile = '/profile';

  static final pages = [
    GetPage(name: splash, page: () => SplashScreen(), binding: SplashBinding()),
    GetPage(name: onboarding, page: () => OnboardingScreen()),
    GetPage(name: login, page: () => LoginScreen(), binding: LoginBinding()),
    GetPage(name: signup, page: () => SignupScreen(), binding: SignupBinding()),
    GetPage(
      name: forgetPassword,
      page: () => ForgetPasswordScreen(),
      binding: ForgetPasswordBinding(),
    ),
    GetPage(
      name: codeVerify,
      page: () => CodeVerificationScreen(),
      binding: CodeVerificationBinding(),
    ),
    GetPage(
      name: resetPassword,
      page: () => ResetPasswordScreen(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(name: home, page: () => HomeScreen(), binding: HomeBinding()),
    GetPage(
      name: calendar,
      page: () => CalendarScreen(),
      binding: CalendarBinding(),
    ),
    GetPage(
      name: profile,
      page: () => ProfileScreen(),
      binding: ProfileBinding(),
    ),
  ];
}
