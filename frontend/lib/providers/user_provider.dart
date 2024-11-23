import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/data/models/user_model.dart';
import 'package:frontend/data/repositories/user_service.dart';
import 'package:frontend/utils/utils.dart';

class UserNotifier extends StateNotifier<UserModel?> {
  final UserService _userService = UserService();

  UserNotifier() : super(null);

  Future<void> initializeUser() async {
    final deviceId = await getDeviceId();
    var user = await _userService.getCachedUser();

    if (user == null) {
      // Load user from API or create if not found
      user = await _userService.loadUser(deviceId) ??
          await _userService.createUser(deviceId);

      if (user != null) {
        await _userService.cacheUser(user);
      }
    }

    state = user;
  }

  void updateUser(UserModel user) async {
    await _userService.cacheUser(user);
    state = user;
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserModel?>((ref) {
  return UserNotifier();
});
