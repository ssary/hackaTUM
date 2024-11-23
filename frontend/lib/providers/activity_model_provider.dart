import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/data/models/activity_model.dart';
import 'package:http/http.dart' as httpreq;

class CurrentActivityNotifier extends StateNotifier<ActivityModel?> {
  CurrentActivityNotifier() : super(null);

  void setActivity(ActivityModel activity, String userID) async {
    state = activity;

    // pos the activity to the mongo db via http
    postActivity(userID, activity);
  }

  void clearActivity() {
    state = null;
  }

  void updateActivity(ActivityModel updatedActivity) {
    if (state != null && state!.id == updatedActivity.id) {
      state = updatedActivity;
    }
  }

  Future<void> postActivity(String createdBy, ActivityModel activity) async {
    // Define the endpoint URL
    final String endpoint =
        'https://your-api-url.com/activities'; // Replace with your actual endpoint URL

    // Build the request body
    final Map<String, dynamic> requestBody = {
      "description": activity.description,
      "minUsers": activity.minParticipants,
      "maxUsers": activity.maxParticipants,
      "timerange": {
        "startTime": activity.timeRange['startTime'],
        "endTime": activity.timeRange['endTime'],
      },
      "location": {
        "lon": activity.location['lon'],
        "lat": activity.location['lat'],
        "radius": activity.location['radius'],
      },
      "joinedUsers": activity.participants,
    };

    try {
      // Make the POST request
      final response = await httpreq.post(
        Uri.parse('$endpoint?created_by=$createdBy'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(requestBody),
      );

      // Handle the response
      if (response.statusCode == 200) {
        print('Activity posted successfully: ${response.body}');
      } else {
        print('Failed to post activity. Status code: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (e) {
      print('Error occurred while posting activity: $e');
    }
  }
}

final currentActivityProvider =
    StateNotifierProvider<CurrentActivityNotifier, ActivityModel?>((ref) {
  return CurrentActivityNotifier();
});
