import 'package:flutter/material.dart';
import 'package:frontend/common_widgets/join_activity_tile.dart';
import 'package:frontend/common_widgets/solid_button.dart';
import 'package:frontend/constants/app_spacing.dart';
import 'package:frontend/routing/app_routing.dart';
import 'package:frontend/screens/activity_selection/widgets/pending_request.dart';
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
          // Title
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(22, 26, 16, 16),
              child: Text(
                "Your Request",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
          ),
          Container(
            color: Colors.grey,
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 0, 20),
            child: PendingActivityRequest(
              title: "Frisbee in the Park",
              location: "Luitpoldpark",
              startTime: "15:00",
              endTime: "17:00",
              minParticipants: 5,
              maxParticipants: 10,
              onOpen: () {
                // Navigate to activity details for the selected activity
                context.goNamed(AppRouting.activityDetails);
              },
            ),
          ),
          Container(
            color: Colors.grey,
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 19, 0, 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Similar Activities",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
            child: FutureBuilder(
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
                      padding: const EdgeInsets.all(4),
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
          ),
          gapH16,
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 24),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: const Icon(
                    Icons.arrow_back_outlined,
                    color: AppColors.secondaryColor,
                    size: 32,
                  ),
                ),
              ),
            ),
          ),
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
