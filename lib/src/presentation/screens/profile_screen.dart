// lib/src/presentation/screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';
import '../controllers/auth_controller.dart';

class ProfileScreen extends StatelessWidget {
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("More")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info
            Text(
              "Stan Mcwong",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              "stanmcwong24@gmail.com",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: 20),

            // Edit Profile
            ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.edit, color: Colors.blue),
              ),
              title: Text("Edit Profile"),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Get.snackbar("Edit Profile", "Navigate to edit screen");
              },
            ),

            // Change Password
            ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.vpn_key, color: Colors.orange),
              ),
              title: Text("Change Password"),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Get.toNamed(AppRoutes.resetPassword);
              },
            ),

            // Logout
            ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.logout, color: Colors.red),
              ),
              title: Text("Logout"),
              onTap: () {
                Get.dialog(
                  AlertDialog(
                    title: Text("Confirm Logout"),
                    content: Text("Are you sure you want to log out?"),
                    actions: [
                      TextButton(
                        onPressed: () => Get.back(),
                        child: Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                          authController.logout();
                        },
                        child: Text("Logout"),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
