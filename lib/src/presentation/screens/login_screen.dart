// lib/src/presentation/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../../routes/app_routes.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  final AuthController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Here")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "Start your journey to mastering money with fun, interactive lessons today!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            CustomTextField(
              label: "Email",
              onChanged: (val) => controller.email(val),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 10),
            CustomTextField(
              label: "Password",
              onChanged: (val) => controller.password(val),
              obscureText: true,
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Get.toNamed(AppRoutes.forgetPassword),
                child: Text("Forget Password"),
              ),
            ),
            SizedBox(height: 20),
            Obx(
              () => CustomButton(
                onPressed: controller.isLoading.value ? null : controller.login,
                text: "Log In",
                isLoading: controller.isLoading.value,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "By continuing, you agree to the Boundless Inc Terms & Conditions and Privacy Policy.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
