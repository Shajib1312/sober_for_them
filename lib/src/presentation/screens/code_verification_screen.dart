// lib/src/presentation/screens/code_verification_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class CodeVerificationScreen extends StatelessWidget {
  final AuthController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Apply Code Here")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Please check your email. Give correct authentication code here.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 40),
            CustomTextField(
              label: "Enter 6-digit code",
              onChanged: (val) => controller.otp(val),
              keyboardType: TextInputType.number,
              maxLength: 6,
            ),
            SizedBox(height: 30),
            Obx(
              () => CustomButton(
                onPressed:
                    controller.isLoading.value ? null : controller.verifyOtp,
                text: "Apply Code",
                isLoading: controller.isLoading.value,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
