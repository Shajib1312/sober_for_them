// lib/src/presentation/bindings/forget_password_binding.dart
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class ForgetPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }
}
