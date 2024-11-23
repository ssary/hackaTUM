import 'package:flutter/material.dart';
import 'package:frontend/app.dart';
import 'package:go_router/go_router.dart';

void main() {
  GoRouter.optionURLReflectsImperativeAPIs = true;
  runApp(MeetingApp());
}
