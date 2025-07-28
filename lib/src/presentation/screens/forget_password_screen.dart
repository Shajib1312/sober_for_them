// lib/src/presentation/screens/forget_password_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../controllers/auth_controller.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class ForgetPasswordScreen extends StatelessWidget {
  final AuthController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Forget Password")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Start your journey to mastering money with fun, interactive lessons today!",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 40),
            CustomTextField(
              label: "Email",
              onChanged: (val) => controller.email(val),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 30),
            Obx(
              () => CustomButton(
                onPressed: controller.isLoading.value
                    ? null
                    : controller.forgotPassword,
                text: "Send Code",
                isLoading: controller.isLoading.value,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
