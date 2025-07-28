// lib/src/presentation/screens/reset_password_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  final AuthController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reset Password Here')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reset your account password here',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 40),
            CustomTextField(
              label: 'New Password',
              onChanged: (val) => controller.password(val),
              obscureText: true,
            ),
            SizedBox(height: 20),
            CustomTextField(
              label: 'Confirm Password',
              onChanged: (val) => controller.password(val),
              obscureText: true,
            ),
            SizedBox(height: 30),
            Obx(
              () => CustomButton(
                onPressed: controller.isLoading.value
                    ? null
                    : controller.resetPassword,
                text: 'Reset Password',
                isLoading: controller.isLoading.value,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
