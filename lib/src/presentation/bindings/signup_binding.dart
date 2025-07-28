// lib/src/presentation/bindings/signup_binding.dart
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class SignupBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }
}
