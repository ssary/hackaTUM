import 'package:flutter/material.dart';
import 'package:frontend/common_widgets/solid_button.dart';
import 'package:frontend/constants/app_spacing.dart';
import 'package:frontend/routing/app_routing.dart';
import 'package:frontend/theme/colors.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(Spacing.p8),
                    child: Icon(
                      Icons.person,
                      size: 48,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(Spacing.p8),
                    child: Icon(
                      Icons.list,
                      size: 48,
                    ),
                  ),
                ],
              ),
              gapH104,
              IconButton(
                  onPressed: () {
                    context.goNamed(AppRouting.createActivity);
                  },
                  icon: Icon(Icons.circle_rounded, size: 300)),
              gapH16,
              SolidButton(
                  text: "Choose from past activities",
                  backgroundColor: AppColors.primaryColor,
                  onPressed: () {})

              // make two big text with different fonts tpo check if it works
              ,
              Text(
                "Hello",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                "Hello",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
              )
            ],
          ),
        ],
      ),
    );
  }
}
