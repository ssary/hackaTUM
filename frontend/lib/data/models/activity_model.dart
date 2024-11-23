import 'package:flutter/material.dart';
import 'package:frontend/data/models/user_model.dart';

class ActivityModel {
  final String id;
  final String description;
  final int minParticipants;
  final int maxParticipants;
  final Map<String, TimeOfDay> timeRange;
  final Map<String, double> location;
  final List<UserModel> participants;

  ActivityModel({
    required this.id,
    required this.description,
    required this.minParticipants,
    required this.maxParticipants,
    required this.timeRange,
    required this.location,
    required this.participants,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      id: json['id'],
      description: json['description'],
      minParticipants: json['minParticipants'],
      maxParticipants: json['maxParticipants'],
      timeRange: json['timeRange'],
      location: json['location'],
      participants: json['participants'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'minParticipants': minParticipants,
      'maxParticipants': maxParticipants,
      'timeRange': timeRange,
      'location': location,
      'participants': participants,
    };
  }
}
