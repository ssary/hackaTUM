import 'package:flutter/material.dart';
import 'package:frontend/common_widgets/chat_window.dart';
import 'package:frontend/common_widgets/free_text_input.dart';
import 'package:frontend/common_widgets/participant_list.dart';
import 'package:frontend/common_widgets/pending_request.dart';
import 'package:frontend/common_widgets/solid_button.dart';
import 'package:frontend/constants/app_spacing.dart';
import 'package:frontend/routing/app_routing.dart';
import 'package:frontend/theme/colors.dart';
import 'package:go_router/go_router.dart';

class ActivityDetailsScreen extends StatefulWidget {
  const ActivityDetailsScreen({super.key});

  @override
  State<ActivityDetailsScreen> createState() => _ActivityDetailsScreenState();
}

class _ActivityDetailsScreenState extends State<ActivityDetailsScreen> {
  //TODO
  List peopleJoined = ["Person 1", "Person 2", "Person 3"];

  late double screenHeight;
  late double screenWidth;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.surfaceColor,
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 24, 16, 18),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => {
                      context.go(AppRouting.home)
                    },
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
                    "Your Activity",
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
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 16, 22, 16),
            child: CollapsablePendingActivityRequest(
                title: "Frisbee in the Park",
                location: "Luitpoldpark",
                startTime: "15:00",
                endTime: "17:00",
                minParticipants: 2,
                maxParticipants: 4,
                includeOpenButton: false,
                onOpen: () => {}),
          ),
          Container(
            color: const Color.fromARGB(255, 217, 217, 217),
            height: 1,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(30, 16, 22, 16),
            child: CollapsableParticipantList(
              participants: [
                ActivityParticipant(
                    name: "You", gender: "Male", pfpUrl: "user.png", age: 23),
                ActivityParticipant(
                    name: "Isabella",
                    gender: "Female",
                    pfpUrl: "user.png",
                    age: 22)
              ],
              denominator: 4,
            ),
          ),
          Container(
            color: const Color.fromARGB(255, 217, 217, 217),
            height: 1,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(30, 22, 0, 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Chat",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 22, 30, 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const ChatMessage(
                    isSender: false,
                    text: 'Hey, lol',
                    name: 'Hans',
                    messageTimestamp: '15:21',
                    imageURL: 'user.png',
                  ),
                  SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        SizedBox(
                          height: 40,
                          width: screenWidth - 50 - 40 - 10,
                          child: FreeTextInputBox(
                              textEditingController: TextEditingController(),
                              hintText: "Chat with the group..."),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: AppColors.secondaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            onPressed: () => {},
                            icon: const Icon(Icons.arrow_forward,
                                color: AppColors.secondaryColor),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
