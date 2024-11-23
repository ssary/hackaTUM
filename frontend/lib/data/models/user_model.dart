import 'package:flutter/material.dart';

class UserModel {
  final String uid;
  final String name;
  final String avatarUrl;
  final int age;
  final String gender;
  final TimeOfDay createdAt;
  final TimeOfDay updatedAt;

  UserModel({
    required this.uid,
    required this.name,
    required this.avatarUrl,
    required this.age,
    required this.gender,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      name: json['name'],
      avatarUrl: json['avatarUrl'],
      age: json['age'],
      gender: json["gebnder"],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'avatarUrl': avatarUrl,
      'age': age,
      'gender': gender,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
