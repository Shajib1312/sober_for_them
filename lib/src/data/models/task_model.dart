// lib/src/data/models/task_model.dart
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

part 'task_model.g.dart';

@HiveType(typeId: 1)
class TaskModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final bool isCompleted;

  @HiveField(4)
  final String? description;

  TaskModel({
    required this.id,
    required this.title,
    required this.date,
    this.isCompleted = false,
    this.description,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: json['title'],
      date: DateTime.parse(json['date']),
      isCompleted: json['isCompleted'] ?? false,
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date': date.toIso8601String(),
      'isCompleted': isCompleted,
      'description': description,
    };
  }

  String get formattedDate {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  String get dayOfMonth {
    return date.day.toString();
  }

  String get dayOfWeek {
    return DateFormat('EEE').format(date).toUpperCase();
  }
}
