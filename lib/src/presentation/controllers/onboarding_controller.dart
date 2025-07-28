// lib/src/presentation/controllers/onboarding_controller.dart
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;
  var isLastPage = false.obs;

  void nextPage() {
    if (currentPage.value < 1) {
      currentPage.value++;
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      currentPage.value--;
    }
  }

  void goToLogin() {
    Get.toNamed('/login');
  }

  void goToExplore() {
    Get.toNamed('/login');
  }
}
