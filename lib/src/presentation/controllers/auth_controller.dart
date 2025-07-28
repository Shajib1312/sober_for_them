// lib/src/presentation/controllers/auth_controller.dart
import 'package:get/get.dart';

import '../../data/models/user_model.dart';
import '../../data/repositories/auth_repository.dart';
import '../../routes/app_routes.dart';

import '../../utils/storage.dart';

class AuthController extends GetxController {
  final AuthRepository _repo = AuthRepository();

  var email = ''.obs;
  var password = ''.obs;
  var fullName = ''.obs;
  var otp = ''.obs;
  var isLoading = false.obs;
  var user = Rxn<UserModel>();
  var currentScreen = 'login'.obs;

  @override
  void onInit() {
    super.onInit();
    user.value = Storage.getUser();
  }

  Future<void> login() async {
    if (email.value.isEmpty || password.value.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields');
      return;
    }

    isLoading(true);
    final result = await _repo.login(email.value, password.value);
    isLoading(false);

    if (result.success && result.data != null) {
      user(result.data!);
      Get.offAllNamed(AppRoutes.home);
      Get.snackbar('Success', result.message);
    } else {
      Get.snackbar('Login Failed', result.message);
    }
  }

  Future<void> register() async {
    if (fullName.value.isEmpty ||
        email.value.isEmpty ||
        password.value.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields');
      return;
    }

    isLoading(true);
    final result = await _repo.register(
      fullName.value,
      email.value,
      password.value,
    );
    isLoading(false);

    if (result.success) {
      Get.snackbar('Success', result.message);
      Get.toNamed(AppRoutes.login);
    } else {
      Get.snackbar('Register Failed', result.message);
    }
  }

  Future<void> forgotPassword() async {
    if (email.value.isEmpty) {
      Get.snackbar('Error', 'Please enter your email');
      return;
    }

    isLoading(true);
    final result = await _repo.forgotPassword(email.value);
    isLoading(false);

    if (result.success) {
      Get.snackbar('Check Email', result.message);
      Get.toNamed(AppRoutes.codeVerify);
    } else {
      Get.snackbar('Error', result.message);
    }
  }

  Future<void> verifyOtp() async {
    if (otp.value.length != 6) {
      Get.snackbar('Error', 'Please enter a valid 6-digit code');
      return;
    }

    isLoading(true);
    final result = await _repo.verifyOtp(email.value, int.parse(otp.value));
    isLoading(false);

    if (result.success) {
      Get.snackbar('Success', result.message);
      Get.toNamed(AppRoutes.resetPassword);
    } else {
      Get.snackbar('Invalid OTP', result.message);
    }
  }

  Future<void> resetPassword() async {
    if (password.value.length < 8) {
      Get.snackbar('Error', 'Password must be at least 8 characters');
      return;
    }

    isLoading(true);
    final result = await _repo.resetPassword(email.value, password.value);
    isLoading(false);

    if (result.success) {
      Get.snackbar('Success', result.message);
      Get.offAllNamed(AppRoutes.login);
    } else {
      Get.snackbar('Reset Failed', result.message);
    }
  }

  Future<void> getProfile() async {
    final token = await Storage.getToken();
    if (token == null) return;

    final result = await _repo.getProfile(token);
    if (result.success && result.data != null) {
      user(result.data!);
    }
  }

  Future<void> updateProfile(String newFullName) async {
    final token = await Storage.getToken();
    if (token == null) return;

    isLoading(true);
    final result = await _repo.updateProfile(newFullName, token);
    isLoading(false);

    if (result.success && result.data != null) {
      user(result.data!);
      Get.snackbar('Success', result.message);
    } else {
      Get.snackbar('Update Failed', result.message);
    }
  }

  Future<void> changePassword(String oldPass, String newPass) async {
    final token = await Storage.getToken();
    if (token == null) return;

    if (newPass.length < 8) {
      Get.snackbar('Error', 'New password must be at least 8 characters');
      return;
    }

    isLoading(true);
    final result = await _repo.changePassword(oldPass, newPass, token);
    isLoading(false);

    if (result.success) {
      Get.snackbar('Success', result.message);
      Get.back();
    } else {
      Get.snackbar('Change Failed', result.message);
    }
  }

  Future<void> logout() async {
    await Storage.clear();
    user(null);
    Get.offAllNamed(AppRoutes.splash);
  }
}
