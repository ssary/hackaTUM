import 'package:flutter/material.dart';
import 'package:frontend/common_widgets/join_activity_tile.dart';
import 'package:frontend/common_widgets/solid_button.dart';
import 'package:frontend/constants/app_spacing.dart';
import 'package:frontend/routing/app_routing.dart';
import 'package:frontend/theme/colors.dart';
import 'package:go_router/go_router.dart';

class ActivitySelectionScreen extends StatefulWidget {
  const ActivitySelectionScreen({super.key});

  @override
  State<ActivitySelectionScreen> createState() =>
      _ActivitySelectionScreenState();
}

class _ActivitySelectionScreenState extends State<ActivitySelectionScreen> {
  late Future<List<dynamic>> _loadActivties;

  @override
  void initState() {
    super.initState();

    _loadActivties = loadActivities();
  }

  late double screenHeight;
  late double screenWidth;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 200,
            width: screenWidth,
            color: Colors.blue,
            child: Text("Your request"),
          ),
          gapH16,
          Text("Join users searching for similar activities"),
          FutureBuilder(
              future: _loadActivties,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Text('Error loading activities');
                } else {
                  List activties = snapshot.data as List;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      //dynamic activity = activties[index];
                      return JoinActivityTile(
                        title: "Frisbee in the Park",
                        location: "Luitpoldpark",
                        startTime: "15:00",
                        endTime: "17:00",
                        userProfilePicturePaths: const [
                          "user.png",
                          "user.png",
                          "user.png",
                        ],
                        minParticipants: 5,
                        onJoin: () {
                          // Navigate to activity details for the selected activity
                          context.goNamed(AppRouting.activityDetails);
                        },
                      );
                    },
                  );
                }
              }),
          gapH16,
          SolidButton(
              text: "Create your own Activity instead ",
              backgroundColor: AppColors.darkGray,
              onPressed: () {
                // Navigate to activity details for your activity
                context.goNamed(AppRouting.activityDetails);
              }),
          gapH32
        ],
      )),
    );
  }

  //TODO: Implement _buildActivityList
  Future<List<dynamic>> loadActivities() async {
    // Load activities from the backend
    return [1, 2, 3];
  }
}
