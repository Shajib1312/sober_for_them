// lib/src/presentation/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';
import '../controllers/auth_controller.dart';
import '../widgets/custom_button.dart';

class HomeScreen extends StatelessWidget {
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Business"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Get.snackbar("Edit", "Profile editing enabled");
            },
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              Get.snackbar("Saved", "Changes saved successfully");
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              Get.toNamed(AppRoutes.profile);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "20-10-3035",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: 10),
            Text(
              "-BusinessName-BrandName...",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildField("Business Name", "-BusinessName"),
            _buildField("Brand Name", "-Brand Name"),
            _buildField("PAN Number", "-PANNumber"),
            DropdownButtonFormField(
              value: null,
              items:
                  [
                    'Fashion & Clothing',
                    'Home Accessories',
                    'Tech',
                    'Health',
                  ].map((String value) {
                    return DropdownMenuItem(value: value, child: Text(value));
                  }).toList(),
              onChanged: (val) {},
              decoration: InputDecoration(
                labelText: "Business Category",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Tasks",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: Text("Task 3"),
              trailing: Icon(Icons.check_box_outline_blank),
            ),
            ListTile(title: Text("Task 4"), trailing: Icon(Icons.check_box)),
            SizedBox(height: 20),
            CustomButton(
              onPressed: () => Get.toNamed(AppRoutes.calendar),
              text: "See Your Task",
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () => Get.toNamed(AppRoutes.profile),
                child: Text("More", style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 12, color: Colors.grey)),
          Text(value, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
