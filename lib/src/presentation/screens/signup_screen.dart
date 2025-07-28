// lib/src/presentation/screens/signup_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class SignupScreen extends StatelessWidget {
  final AuthController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Join Now"),
      ),
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
              label: "User Name",
              onChanged: (val) => controller.fullName(val),
            ),
            SizedBox(height: 10),
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
            SizedBox(height: 20),
            Obx(() => CustomButton(
                  onPressed:
                      controller.isLoading.value ? null : controller.register,
                  text: "Sign Up",
                  isLoading: controller.isLoading.value,
                )),
          ],
        ),
      ),
    );
  }
}
