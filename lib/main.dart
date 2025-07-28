// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'src/routes/app_routes.dart';
import 'src/utils/hive_adapter.dart';
import 'src/utils/storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await HiveAdapter.init();

  // Initialize storage
  await Storage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SoberForThem',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      initialRoute: _getInitialRoute(),
      getPages: AppRoutes.pages,
    );
  }

  String _getInitialRoute() {
    final token = Storage.getToken();
    final hasOnboarded = Storage.hasOnboarded();

    if (token != null) return AppRoutes.home;
    if (hasOnboarded) return AppRoutes.login;
    return AppRoutes.splash;
  }
}
