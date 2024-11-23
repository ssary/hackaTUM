import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/constants/app_spacing.dart';
import 'package:frontend/data/models/activity_model.dart';
import 'package:frontend/data/models/user_model.dart';
import 'package:frontend/providers/activity_model_provider.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:frontend/routing/app_routing.dart';
import 'package:frontend/screens/create_activity/widgets/choose_popular_activities_widget.dart';
import 'package:frontend/screens/create_activity/widgets/choose_when_widget.dart';
import 'package:frontend/screens/create_activity/widgets/choose_who_widget.dart';
import 'package:frontend/theme/colors.dart';
import 'package:http/http.dart' as httpreq;
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class CreateActivityScreen extends ConsumerStatefulWidget {
  const CreateActivityScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateActivityScreenState();
}

class _CreateActivityScreenState extends ConsumerState<CreateActivityScreen> {
  final _formKey = GlobalKey<FormState>();

  final double _sidePadding = 16.0;
  // Controllers for the text fields
  final TextEditingController _whatController = TextEditingController();
  final TextEditingController _whereController = TextEditingController();
  final TextEditingController _whoMinController = TextEditingController();
  final TextEditingController _whoMaxController = TextEditingController();

  final TimeOfDay _selectedStartTime = TimeOfDay.now();
  final TimeOfDay _selectedEndTime = TimeOfDay.fromDateTime(
    DateTime.now().add(const Duration(hours: 1)),
  );

  double _selectedRadius = 0.0;

  LatLng? _selectedLocation; // Stores the chosen location

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
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _selectedLocation = LatLng(48.265454, 11.669124); // Default to Munich
  }

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
    _whereController.dispose();
    _whoMinController.dispose();
    _whoMaxController.dispose();
    _pageController.dispose();

    super.dispose();
  }

  late double screenWidth;
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        children: _buildScreens(screenWidth).map((screen) {
          return screen.withKey(currentIndex);
        }).toList(),
      ),
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
                  _pageController.animateToPage(
                    currentIndex - 1,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
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
              onPressed: () async {
                if (currentIndex == 3) {
                  if (_formKey.currentState!.validate()) {
                    // Get location name from lat/lon
                    String name = await getLocationName(
                            _selectedLocation!.latitude,
                            _selectedLocation!.longitude) ??
                        "Unknown Location";

                    // Create the activity using the provider
                    final activity = ActivityModel(
                      id: "new_activity", // Generate or replace with actual ID
                      description: _whatController.text,
                      minParticipants: int.parse(_whoMinController.text),
                      maxParticipants: int.parse(_whoMaxController.text),
                      timeRange: {
                        "startTime": _selectedStartTime,
                        "endTime": _selectedEndTime,
                      },
                      location: {
                        "lat": _selectedLocation!.latitude,
                        "lon": _selectedLocation!.longitude,
                        "name": name,
                        "radius": _selectedRadius,
                      },
                      participants: [],
                    );

                    // Add the activity to the user's list of activities
                    final user = ref.read(userProvider);

                    // Set the activity in the provider
                    ref
                        .read(currentActivityProvider.notifier)
                        .setActivity(activity, user!.uid);

                    // Navigate to the next screen
                    if (mounted) {
                      context.go(AppRouting.selectActivity);
                    }
                  }
                }

                _pageController.animateToPage(
                  currentIndex + 1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryColor, // Green button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: _sidePadding,
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
      ChooseWhenWidget(
        startTime: _selectedStartTime,
        endTime: _selectedEndTime,
      ),
      ChooseWhoWidget(
          minParticipantsController: _whoMinController,
          maxParticipantsController: _whoMaxController,
          formKey: _formKey),
    ];
  }

  Widget chooseWhatWidget(screenWidth) {
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Padding(
          padding: EdgeInsets.all(_sidePadding),
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
          padding: EdgeInsets.all(_sidePadding),
          child: Text(
            "Choose a popular activity",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(_sidePadding, 0, _sidePadding, 0),
          child: ChoosePopularActivitiesWidget(
            activities: popularActivitiesList,
            index: currentIndex,
            pageController: _pageController,
            whatController: _whatController,
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
          padding: EdgeInsets.all(_sidePadding),
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
          padding:
              EdgeInsets.fromLTRB(_sidePadding, _sidePadding, _sidePadding, 0),
          child: Text(
            "Have something in mind?",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
          ),
        ),

        Padding(
          padding: EdgeInsets.all(_sidePadding),
          child: TextField(
            controller: _whatController,
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Title
          Text(
            "Select a Location",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
          ),
          const SizedBox(height: 20),
// Map
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                initialCenter: _selectedLocation ??
                    LatLng(48.265454, 11.669124), // Default to Munich City
                initialZoom: 15.0,
                onTap: (tapPosition, point) {
                  setState(() {
                    _selectedLocation = point;
                    _updateWhereController();
                  });
                },
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                if (_selectedLocation != null)
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: _selectedLocation!,
                        width: 40,
                        height: 40,
                        child: const Icon(
                          Icons.location_pin,
                          size: 40,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),

                // Add a circle to show the search radius
                if (_selectedLocation != null)
                  CircleLayer(
                    circles: [
                      CircleMarker(
                        point: _selectedLocation!,
                        color: Colors.blue.withOpacity(0.3),
                        borderStrokeWidth: 2,
                        borderColor: Colors.blue,
                        radius: _selectedRadius * 100,
                      ),
                    ],
                  ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Radius selection
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Set Search Radius: ${_selectedRadius.toStringAsFixed(1)} km",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Slider(
                value: _selectedRadius,
                min: 0.0,
                max: 20.0,
                divisions: 49,
                label: "${_selectedRadius.toStringAsFixed(1)} km",
                onChanged: (value) {
                  setState(() {
                    _selectedRadius = value;
                    _updateWhereController();
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Selected location display
          TextField(
            controller: _whereController,
            readOnly: true,
            decoration: InputDecoration(
              labelText: "Selected Location",
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }

  void _updateWhereController() {
    if (_selectedLocation != null) {
      _whereController.text =
          "Lat: ${_selectedLocation!.latitude.toStringAsFixed(4)}, "
          "Lng: ${_selectedLocation!.longitude.toStringAsFixed(4)} "
          "(Radius: ${_selectedRadius.toStringAsFixed(1)} km)";
    } else {
      _whereController.text = "No location selected";
    }
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
          return GestureDetector(
              onTap: () {
                _whatController.text = popularEventsList[index];
                _pageController.animateToPage(
                  currentIndex + 1,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              child: Container(
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
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppColors.secondaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        },
      )
    ]);
  }

  Future<String?> getLocationName(double latitude, double longitude) async {
    final url = Uri.parse(
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=$latitude&lon=$longitude&zoom=18&addressdetails=1');
    final response = await httpreq.get(url, headers: {
      'User-Agent': 'Flutter App',
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['display_name']; // Full location name
    } else {
      return null; // Handle error appropriately
    }
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
