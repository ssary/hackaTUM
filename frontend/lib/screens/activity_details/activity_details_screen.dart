import 'package:flutter/material.dart';
import 'package:frontend/common_widgets/solid_button.dart';
import 'package:frontend/constants/app_spacing.dart';
import 'package:frontend/routing/app_routing.dart';
import 'package:frontend/theme/colors.dart';
import 'package:go_router/go_router.dart';

class ActivityDetailsScreen extends StatefulWidget {
  const ActivityDetailsScreen({super.key});

  @override
  State<ActivityDetailsScreen> createState() => _ActivityDetailsScreenState();
}

class _ActivityDetailsScreenState extends State<ActivityDetailsScreen> {
  //TODO
  List peopleJoined = ["Person 1", "Person 2", "Person 3"];

  late double screenHeight;
  late double screenWidth;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 300,
            width: screenWidth,
            color: Colors.lightBlue,
            child: Text("Your activity"),
          ),
          gapH32,
          Text("Waiting Room"),
          ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("Person ${peopleJoined[index]}"),
                );
              },
              itemCount: 3),
          gapH24,
          SolidButton(
              text: "Open Chat",
              backgroundColor: Colors.blue,
              onPressed: () {}),
          gapH24,
          SolidButton(
              text: "Cancel Activity",
              backgroundColor: AppColors.errorRed,
              onPressed: () {
                //TODO:
                context.goNamed(AppRouting.home);
              })
        ],
      ),
    );
  }
}
