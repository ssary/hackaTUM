import 'package:flutter/material.dart';

class ChooseWhoWidget extends StatefulWidget {
  TextEditingController minParticipantsController;
  TextEditingController maxParticipantsController;
  final GlobalKey<FormState> formKey;

  ChooseWhoWidget(
      {super.key,
      required this.minParticipantsController,
      required this.maxParticipantsController,
      required this.formKey});

  @override
  State<ChooseWhoWidget> createState() => _ChooseWhoWidgetState();
}

class _ChooseWhoWidgetState extends State<ChooseWhoWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: widget.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Select Participants",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
              const SizedBox(height: 20),

              // Minimum participants input
              TextFormField(
                controller: widget.minParticipantsController,
                decoration: InputDecoration(
                  labelText: "Minimum Participants",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a minimum number of participants.";
                  }
                  final min = int.tryParse(value);
                  if (min == null || min <= 0) {
                    return "Minimum must be a positive number.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Maximum participants input
              TextFormField(
                controller: widget.maxParticipantsController,
                decoration: InputDecoration(
                  labelText: "Maximum Participants (optional)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a maximum number of participants.";
                  }
                  final max = int.tryParse(value);
                  final min =
                      int.tryParse(widget.minParticipantsController.text) ?? 0;
                  if (max == null || max <= 0) {
                    return "Maximum must be a positive number.";
                  }
                  if (max < min) {
                    return "Maximum cannot be less than Minimum.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
