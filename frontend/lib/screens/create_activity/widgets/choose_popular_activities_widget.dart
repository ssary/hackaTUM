import 'package:flutter/material.dart';
import 'package:frontend/constants/app_spacing.dart';
import 'package:frontend/theme/colors.dart';

class ChoosePopularActivitiesWidget extends StatefulWidget {
  final List<String> activities; // List of activities passed as input

  const ChoosePopularActivitiesWidget({
    super.key,
    required this.activities,
  });

  @override
  State<ChoosePopularActivitiesWidget> createState() =>
      _ChoosePopularActivitiesWidgetState();
}

class _ChoosePopularActivitiesWidgetState
    extends State<ChoosePopularActivitiesWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          "Choose a popular activity",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
        ),
        gapH16,

        // Buttons
        Wrap(
          spacing: 16.0,
          runSpacing: 8.0,
          children: widget.activities.map((activity) {
            return ElevatedButton(
              onPressed: () {
                // Empty action for now
                //TODO impelement logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5C925E), // Green button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 12.0,
                ),
              ),
              child: Text(
                activity,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: AppColors.surfaceColor),
              ), // Use the activity name as button text
            );
          }).toList(),
        ),
      ],
    );
  }
}
