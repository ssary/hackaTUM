class ActivityModel {
  final String id;
  final String description;
  final Map<String, dynamic> location;
  final Map<String, dynamic> timeRange;
  final int minParticipants;
  final int maxParticipants;
  final List<String> participants;

  ActivityModel({
    required this.id,
    required this.description,
    required this.location,
    required this.timeRange,
    required this.minParticipants,
    required this.maxParticipants,
    required this.participants,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      id: json['id'] as String,
      description: json['description'] as String,
      location: json['location'] as Map<String, dynamic>,
      timeRange: json['timeRange'] as Map<String, dynamic>,
      minParticipants: json['minParticipants'] as int,
      maxParticipants: json['maxParticipants'] as int,
      participants: List<String>.from(json['participants'] as List<dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'location': location,
      'timeRange': timeRange,
      'minParticipants': minParticipants,
      'maxParticipants': maxParticipants,
      'participants': participants,
    };
  }
}
