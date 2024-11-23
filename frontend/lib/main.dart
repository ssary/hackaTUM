import 'package:flutter/material.dart';
import 'package:frontend/app.dart';
import 'package:frontend/providers/activity_model_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() {
  GoRouter.optionURLReflectsImperativeAPIs = true;
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ActivityModelProvider()),
  ], child: MeetingApp()));
}
