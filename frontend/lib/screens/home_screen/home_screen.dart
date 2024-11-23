import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
    "Activity 1: Hiking",
    "Activity 2: Painting",
    "Activity 3: Cooking Class",
    "Activity 4: Yoga Session",
    "Activity 5: Photography Walk",
  ];

  @override
  void initState() {
    super.initState();

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

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(Spacing.p8),
                    child: Image.asset(
                      "munich_logo.png",
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(Spacing.p8),
                      child: IconButton(
                        onPressed: () {
                          //TODO: Implement navigation
                        },
                        icon: Image.asset(
                          "list_icon.png",
                        ),
                        iconSize:
                            32, // Ensure the button size matches the icon size
                      )),
                ],
              ),
              gapH104,
              IconButton(
                onPressed: () {
                  context.goNamed(AppRouting.createActivity);
                },
                icon: Image.asset(
                  "people.gif",
                  width: 300,
                  height: 300,
                ),
                iconSize: 300, // Ensure the button size matches the icon size
              ),
              gapH16,
              SolidButton(
                  text: "Choose from past activities",
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: AppColors.surfaceColor),
                  backgroundColor: AppColors.secondaryColor,
                  onPressed: () {}),
              gapH72,
              Text(
                "Recommended Activities",
                style: Theme.of(context).textTheme.headlineSmall,
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
          height: 100, // Fixed height for the carousel items
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
                return LayoutBuilder(
                  builder: (context, constraints) {
                    return Container(
                      width: constraints
                          .maxWidth, // Dynamic width based on screen size
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.secondaryColor,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          recommendedActivities[index],
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                        ),
                      ),
                    );
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
