// lib/src/presentation/bindings/reset_password_binding.dart
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class ResetPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }
}
