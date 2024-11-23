import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/constants/api_endpoint.dart';
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

  // get top k activities
  Future<List<dynamic>> loadActivities(ActivityModel activity) async {
    try {
      final response = await httpreq.get(
          Uri.parse('$baseUrl/activity/?activity_id=${activity.id}/similar'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        print('Error loading activities: ${response.body}');
        return [];
      }
    } catch (e) {
      print('Error loading activities: $e');
      return [];
    }
  }

  Future<void> postActivity(String createdBy, ActivityModel activity) async {
    // Replace with your actual endpoint URL
    try {
      // Make the POST request
      final response = await httpreq.post(
        Uri.parse('$baseUrl/activity/?created_by=$createdBy'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(activity.toJson()),
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
