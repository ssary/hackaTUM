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
    "Grab a coffe",
    "Bierpong match",
    "Drink another RedBull"
  ];

  final popularEventsList = [
    "Christmas Market",
    "New Year's Eve Party",
    "Karaoke Night",
    "Open Mic Night",
  ];

  @override
  void dispose() {
    // Dispose of controllers when no longer needed
    _whatController.dispose();
    _whichController.dispose();
    _whenController.dispose();
    _whoController.dispose();
    super.dispose();
  }

  void _goNext() {
    if (_formKey.currentState?.validate() ?? false) {
      // Handle valid form submission
      print('What: ${_whatController.text}');
      print('Which: ${_whichController.text}');
      print('When: ${_whenController.text}');
      print('Who: ${_whoController.text}');

      context.goNamed(AppRouting.selectActivity);
      dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          color: const Color(0xFFF7F7F7), // Light background color
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                "What do you feel like doing?",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
              const SizedBox(height: 24.0),

              // "Choose a popular activity" section
              ChoosePopularActivitiesWidget(
                activities: popularActivitiesList,
              ),
              gapH24,

              // "Attend an event near you" section
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
                  mainAxisExtent: 180.0, // Fixed height of each item
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
                              color: AppColors.secondaryColor,
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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Colors.white,
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
              ),
              gapH24,
              const Spacer(),
              // "Have something in mind?" section
              Text(
                "Have something in mind?",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                decoration: InputDecoration(
                  hintText: "Describe your activity",
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(
                      color: Color(0xFF5C925E), // Green border when focused
                    ),
                  ),
                ),
              ),
              gapH32,

              // Back and Continue Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                  gapW16,
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5C925E), // Green button
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 48.0,
                        vertical: 16.0,
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hintText,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a value for $label';
        }
        return null;
      },
    );
  }
}
