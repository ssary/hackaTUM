import 'package:flutter/material.dart';
import 'package:frontend/data/models/activity_model.dart';

class ActivityModelProvider extends ChangeNotifier {
  ActivityModel? _currentActivityRequest;

  ActivityModel? get currentActivityRequest => _currentActivityRequest;

  void setCurrentActivityRequest(ActivityModel activity) {
    _currentActivityRequest = activity;
    notifyListeners();
  }

  void updateActivityModel(ActivityModel activity) {
    _currentActivityRequest = activity;
    notifyListeners();
  }
}
