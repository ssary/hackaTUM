import 'package:flutter/material.dart';
import 'package:frontend/constants/app_spacing.dart';
import 'package:frontend/routing/app_routing.dart';
import 'package:frontend/screens/create_activity/widgets/choose_popular_activities_widget.dart';
import 'package:frontend/theme/colors.dart';
import 'package:go_router/go_router.dart';

class CreateActivityScreen extends StatefulWidget {
  const CreateActivityScreen({super.key});

  @override
  State<CreateActivityScreen> createState() => _CreateActivityScreenState();
}

class _CreateActivityScreenState extends State<CreateActivityScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for the text fields
  final TextEditingController _whatController = TextEditingController();
  final TextEditingController _whichController = TextEditingController();
  final TextEditingController _whenController = TextEditingController();
  final TextEditingController _whoController = TextEditingController();

  final popularActivitiesList = [
    "Play Table Tennis",
    "Grab a coffee",
    "Bierpong match",
    "Drink another RedBull"
  ];

  final popularEventsList = [
    "Christmas Market",
    "New Year's Eve Party",
    "Karaoke Night",
    "Open Mic Night",
  ];

  int currentIndex = 0;

  void _nextScreen() {
    setState(() {
      if (currentIndex < _buildScreens(screenWidth).length - 1) {
        currentIndex++; // Go to the next screen
        pressedNext = true;
      }
    });
  }

  bool pressedNext = true;

  void _previousScreen() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--; // Go to the previous screen
        pressedNext = false;
      }
    });
  }

  @override
  void dispose() {
    // Dispose of controllers when no longer needed
    _whatController.dispose();
    _whichController.dispose();
    _whenController.dispose();
    _whoController.dispose();
    super.dispose();
  }

  late double screenWidth;
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: _buildScreens(screenWidth)[currentIndex].withKey(currentIndex),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: // Back and Continue Buttons
            Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                if (currentIndex == 0) {
                  context.go(AppRouting.home);
                } else {
                  _previousScreen();
                }
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
            gapW16,
            Expanded(
                child: ElevatedButton(
              onPressed: _nextScreen,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryColor, // Green button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 48.0,
                  vertical: 24.0,
                ),
              ),
              child: const Text(
                "Continue",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            )),
            gapW8
          ],
        ),
      ),
    );
  }

  List<Widget> _buildScreens(screenWidth) {
    return [
      chooseWhatWidget(screenWidth),
      chooseWhereWidget(),
      chooseWhenWidget(),
      chooseWhoWidget()
    ];
  }

  Widget chooseWhatWidget(screenWidth) {
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Start Activity",
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
          ),
        ),
        gapH8,
        // make a horizontal line
        Container(
          height: 1,
          width: screenWidth,
          color: Colors.grey,
        ),

        // "Choose a popular activity" section
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Choose a popular activity",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ChoosePopularActivitiesWidget(
            activities: popularActivitiesList,
          ),
        ),
        gapH8,
        Container(
          height: 1,
          width: screenWidth,
          color: Colors.grey,
        ),
        gapH16,
        // "Attend an event near you" section

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: recommendedEventsWidget(),
        ),

        gapH24,
        Container(
          height: 1,
          width: screenWidth,
          color: Colors.grey,
        ),
        const Spacer(),
        // "Have something in mind?" section
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
          child: Text(
            "Have something in mind?",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
          ),
        ),
        gapH8,
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Describe your activity",
              hintStyle: const TextStyle(color: Colors.grey),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(
                  color: Colors.grey.shade300,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(
                  color: AppColors.secondaryColor, // Green border when focused
                ),
              ),
            ),
            maxLines: 2,
          ),
        ),
        gapH32,
      ],
    ));
  }

  Widget chooseWhereWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Select a Location",
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
          ),
        ],
      ),
    );
  }

  Widget chooseWhenWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Select a Date and Time",
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
          ),
        ],
      ),
    );
  }

  Widget chooseWhoWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Select Participants",
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
          ),
        ],
      ),
    );
  }

  Widget recommendedEventsWidget() {
    return Column(children: [
      Text(
        "Attend an event near you",
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
      ),
      gapH16,
      GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Two items per row
          crossAxisSpacing: 16.0, // Spacing between items horizontally
          mainAxisSpacing: 16.0, // Spacing between items vertically
          mainAxisExtent: 100.0, // Fixed height of each item
        ),
        itemCount: popularEventsList.length,
        itemBuilder: (context, index) {
          return Container(
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: const Color(0xFF705F8B), // Purple border
              ),
            ),
            child: Column(
              children: [
                Flexible(
                  flex: 2,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                    ),
                    child: Image.asset(
                      "event_image.png", // Make sure the path is correct
                      height: 80,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.surfaceColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                      border: Border.all(
                        color: const Color(0xFF705F8B), // Purple border
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      popularEventsList[index],
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.secondaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      )
    ]);
  }
}

extension WithKey on Widget {
  Widget withKey(int index) {
    return KeyedSubtree(
      key: ValueKey<int>(index),
      child: this,
    );
  }
}
