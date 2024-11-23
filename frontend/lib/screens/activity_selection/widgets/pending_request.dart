import 'package:flutter/material.dart';
import 'package:frontend/theme/colors.dart';

class PendingActivityRequest extends StatelessWidget {
  final String title, location, startTime, endTime;
  final int minParticipants, maxParticipants;
  final VoidCallback onOpen;

  const PendingActivityRequest({
    super.key,
    required this.title,
    required this.location,
    required this.startTime,
    required this.endTime,
    required this.minParticipants,
    required this.maxParticipants,
    required this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle subtitleStyle = const TextStyle(
      fontSize: 12,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 2.0),
        Row(
          children: [
            const Icon(
              Icons.location_pin,
              size: 16.0,
            ),
            const SizedBox(width: 4.0),
            Text(
              location,
              style: subtitleStyle,
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Row(
          children: [
            const Icon(
              Icons.access_time,
              size: 16.0,
            ),
            const SizedBox(width: 4.0),
            Text('$startTime - $endTime', style: subtitleStyle),
          ],
        ),
        const SizedBox(height: 12.0),
        Text(
          'Min: $minParticipants Max: $maxParticipants',
          style: subtitleStyle,
        ),
        const SizedBox(height: 12.0),
        GestureDetector(
          onTap: onOpen,
          child: Container(
            height: 27,
            width: 128,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.25),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Center(
              child: Text(
                'Let others join',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                    fontSize: 12),
              ),
            ),
          ),
        )
      ],
    );
  }
}
