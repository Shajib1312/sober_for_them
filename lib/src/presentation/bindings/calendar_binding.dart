// lib/src/presentation/bindings/calendar_binding.dart
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class CalendarBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }
}
