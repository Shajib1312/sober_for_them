// lib/src/presentation/bindings/login_binding.dart
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }
}
