import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/common_widgets/free_text_input.dart';
import 'package:frontend/constants/app_spacing.dart';
import 'package:frontend/data/models/activity_model.dart';
import 'package:frontend/data/models/user_model.dart';
import 'package:frontend/providers/activity_model_provider.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:frontend/routing/app_routing.dart';
import 'package:frontend/screens/create_activity/widgets/choose_popular_activities_widget.dart';
import 'package:frontend/screens/create_activity/widgets/choose_when_widget.dart';
import 'package:frontend/screens/create_activity/widgets/choose_who_widget.dart';
import 'package:frontend/screens/create_activity/widgets/event_tile.dart';
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
    "Grab lunch",
    "Football",
    "Beerpong match",
    "Chess",
    "Jogging",
    "Calisthenics",
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
            Expanded(
                child: ElevatedButton(
              onPressed: () async {
                if (currentIndex == 0) {
                  if (_whatController.text.isNotEmpty) {
                    context.go(AppRouting.home);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Please enter a description of the activity'),
                      ),
                    );
                    return;
                  }
                }

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
                backgroundColor: AppColors.primaryColor, // Green button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
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
      child: Column(children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 24, 16, 18),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => {},
                  icon: const Icon(
                    Icons.arrow_back_outlined,
                    color: Colors.black,
                    size: 32,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                const Text(
                  "Start Activity",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 32),
                ),
              ],
            ),
          ),
        ),
        Container(
          color: const Color.fromARGB(255, 217, 217, 217),
          height: 1,
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // "Choose a popular activity" section
                const Padding(
                  padding: EdgeInsets.fromLTRB(22, 13, 0, 15),
                  child: Text(
                    "Popular activities",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 5, 22, 17),
                  child: ChoosePopularActivitiesWidget(
                    activities: popularActivitiesList,
                    index: currentIndex,
                    pageController: _pageController,
                    whatController: _whatController,
                  ),
                ),
                Container(
                  height: 1,
                  width: screenWidth,
                  color: const Color.fromARGB(255, 217, 217, 217),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(22, 17, 0, 12),
                  child: Text(
                    "Events near you",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 0, 22, 28),
                  child: recommendedEventsWidget(),
                ),
                Container(
                  height: 1,
                  width: screenWidth,
                  color: const Color.fromARGB(255, 217, 217, 217),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(22, 20, 0, 14),
                  child: Text(
                    "Something in mind?",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
                    child: FreeTextInputBox(
                      textEditingController: _whatController,
                      hintText: "Describe your activity",
                    )),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget chooseWhereWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 24, 16, 18),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => {},
                  icon: const Icon(
                    Icons.arrow_back_outlined,
                    color: Colors.black,
                    size: 32,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                const Text(
                  "Select a Location",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 32),
                ),
              ],
            ),
          ),
        ),
        Container(
          color: const Color.fromARGB(255, 217, 217, 217),
          height: 1,
        ),
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

        // Radius selection
        Padding(
          padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
          child: Column(
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
        ),

        // Selected location display
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
          child: TextField(
            controller: _whereController,
            readOnly: true,
            decoration: const InputDecoration(
              labelText: "Selected Location:",
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
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
      GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Two items per row
          crossAxisSpacing: 12.0, // Spacing between items horizontally
          mainAxisSpacing: 12.0, // Spacing between items vertically
          mainAxisExtent: 99.0, // Fixed height of each item
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
              child: EventTile(
                imgPath: 'event_image.png',
                title: popularEventsList[index],
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
