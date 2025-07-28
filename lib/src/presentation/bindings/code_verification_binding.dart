// lib/src/presentation/bindings/code_verification_binding.dart
import 'package:get/get.dart';


import '../controllers/auth_controller.dart';

class CodeVerificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }
}
