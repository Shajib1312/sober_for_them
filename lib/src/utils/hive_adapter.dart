// lib/src/utils/hive_adapter.dart
import 'package:hive_flutter/hive_flutter.dart';

class HiveAdapter {
  static Future<void> init() async {
    await Hive.initFlutter();

    // Register adapters for Hive models
    // Hive.registerAdapter(UserModelAdapter());
    // Hive.registerAdapter(TaskModelAdapter());
  }

  static Future<Box<T>> openBox<T>(String name) async {
    if (!Hive.isBoxOpen(name)) {
      return await Hive.openBox<T>(name);
    }
    return Hive.box<T>(name);
  }

  static Future<void> close() async {
    await Hive.close();
  }
}
