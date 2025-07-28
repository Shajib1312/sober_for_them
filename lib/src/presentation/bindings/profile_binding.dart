// lib/src/presentation/bindings/profile_binding.dart
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class ProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }
}
