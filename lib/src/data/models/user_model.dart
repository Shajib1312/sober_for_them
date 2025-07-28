// lib/src/data/models/user_model.dart
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String role;

  @HiveField(4)
  final String? phone;

  @HiveField(5)
  final String? image;

  @HiveField(6)
  final String status;

  @HiveField(7)
  final String? fullName;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.phone,
    this.image,
    this.status = 'ACTIVE',
    this.fullName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'] ?? json['fullName'] ?? '',
      email: json['email'],
      role: json['role'],
      phone: json['phone'],
      image: json['image'],
      status: json['status'],
      fullName: json['fullName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'phone': phone,
      'image': image,
      'status': status,
      'fullName': fullName,
    };
  }
}
