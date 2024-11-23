import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend/common_widgets/join_activity_tile.dart';
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
  final PageController _pageController = PageController();
  late Timer _timer;
  int _currentIndex = 0;

  final List<String> recommendedActivities = [
    "Walk in Olympiapark",
    "Cycle Tour",
    "Cooking Class",
    "Yoga Session",
    "Photography Walk",
  ];

  @override
  void initState() {
    super.initState();

    if (_pageController.hasClients && _pageController.page != null) {
      // Set up a timer for auto-slide
      _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
        if (_pageController.hasClients) {
          final nextPage = _pageController.page!.toInt() + 1;
          _pageController.animateToPage(
            nextPage % recommendedActivities.length,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  Widget startActivityButton(double screenWidth) {
    double boxSize = screenWidth - 2 * 59;
    return SizedBox(
      width: boxSize,
      height: boxSize,
      child: GestureDetector(
        onTap: () {
          context.replace(AppRouting.createActivity);
        },
        child: Card(
          shape: RoundedRectangleBorder(
            side: const BorderSide(
                color: Color.fromARGB(255, 217, 217, 217), width: 1.0),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Stack(alignment: Alignment.center, children: [
            Positioned(
                bottom: 0,
                child: Image.asset(
                  "people.gif",
                  width: boxSize * 0.9,
                  height: boxSize * 0.9,
                )),
            Positioned(
              bottom: boxSize * 0.125,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Start Activity',
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward_ios, color: AppColors.primaryColor),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 20, 22, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "munich_logo.png",
                    ),
                    IconButton(
                      onPressed: () {
                        //TODO: Implement navigation
                      },
                      icon: Image.asset("list_icon.png"),
                      color: AppColors.secondaryColor,
                      iconSize:
                          32, // Ensure the button size matches the icon size
                    ),
                  ],
                ),
              ),
              gapH104,
              startActivityButton(screenWidth),
              gapH16,
              Container(
                  width: (screenWidth - 2 * 59) * 0.8,
                  height: 36,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 217, 217, 217),
                        width: 1.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.history,
                        color: AppColors.secondaryColor,
                      ),
                      SizedBox(width: 6),
                      Text(
                        "Repeat a previous activity",
                        style: TextStyle(
                            color: AppColors.secondaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
              gapH72,
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 22),
                  child: Text(
                    "Activities you might like",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              gapH16,
              recommendedActivitiesList(),

              // make two big text with different fonts tpo check if it works
            ],
          ),
        ],
      ),
    );
  }

  Widget recommendedActivitiesList() {
    return Column(
      children: [
        SizedBox(
          height: 132, // Fixed height for the carousel items
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: PageView.builder(
              controller: _pageController,
              itemCount: recommendedActivities.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return JoinActivityTile(
                  title: recommendedActivities[index],
                  location: "Munich",
                  startTime: "15:00",
                  endTime: "17:00",
                  userProfilePicturePaths: const [
                    "user.png",
                    "user.png",
                    "user.png",
                  ],
                  minParticipants: 3 + (index % 3),
                  onJoin: () {
                    // Navigate to activity details for the selected activity
                    context.goNamed(AppRouting.activityDetails);
                  },
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 16), // Space between carousel and indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(recommendedActivities.length, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentIndex == index ? 12 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: _currentIndex == index
                    ? AppColors.primaryColor
                    : AppColors.secondaryColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
      ],
    );
  }
}
