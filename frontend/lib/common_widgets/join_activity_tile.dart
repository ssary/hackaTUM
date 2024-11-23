import 'package:flutter/material.dart';

class JoinActivityTile extends StatelessWidget {
  final String title;
  final String location;
  final String startTime;
  final String endTime;
  final List<String> userProfilePicturePaths;
  final VoidCallback onJoin;

  const JoinActivityTile({
    Key? key,
    required this.title,
    required this.location,
    required this.startTime,
    required this.endTime,
    required this.userProfilePicturePaths,
    required this.onJoin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_pin,
                        size: 16.0,
                      ),
                      const SizedBox(width: 4.0),
                      Text(location),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 16.0,
                      ),
                      const SizedBox(width: 4.0),
                      Text('$startTime - $endTime'),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  SizedBox(
                    height: 40.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: userProfilePicturePaths.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: CircleAvatar(
                            backgroundImage: AssetImage(
                              userProfilePicturePaths[index],
                            ),
                            radius: 16.0,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text('${userProfilePicturePaths.length}/5'),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: onJoin,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[300],
                foregroundColor: Colors.white,
              ),
              child: const Text('Join'),
            ),
          ],
        ),
      ),
    );
  }
}
