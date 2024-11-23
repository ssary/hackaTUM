import 'package:flutter/material.dart';
import 'package:frontend/theme/colors.dart';
import 'package:time_range_picker/time_range_picker.dart';

class ChooseWhenWidget extends StatefulWidget {
  TimeOfDay startTime;
  TimeOfDay endTime;

  ChooseWhenWidget({super.key, required this.startTime, required this.endTime});

  @override
  _ChooseWhenWidgetState createState() => _ChooseWhenWidgetState();
}

class _ChooseWhenWidgetState extends State<ChooseWhenWidget> {
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  @override
  void initState() {
    super.initState();
    _startTime = widget.startTime;
    _endTime = widget.endTime;
  }

  Future<void> _pickTimeRange() async {
    TimeRange? result = await showTimeRangePicker(
      context: context,
      start: _startTime ?? TimeOfDay.now(),
      end:
          _endTime ?? TimeOfDay.now().replacing(hour: TimeOfDay.now().hour + 1),
      interval: const Duration(minutes: 30),
      use24HourFormat: true,
      padding: 30,
      strokeWidth: 20,
      handlerRadius: 14,
      strokeColor: AppColors.secondaryColor,
      handlerColor: AppColors.secondaryColor,
      selectedColor: AppColors.secondaryColor,
      backgroundColor: Colors.black.withOpacity(0.3),
      ticks: 12,
      ticksColor: Colors.white,
      snap: true,
      labels: ["12 am", "3 am", "6 am", "9 am", "12 pm", "3 pm", "6 pm", "9 pm"]
          .asMap()
          .entries
          .map((e) {
        return ClockLabel.fromIndex(idx: e.key, length: 8, text: e.value);
      }).toList(),
      labelOffset: -30,
      labelStyle: const TextStyle(
          fontSize: 22, color: Colors.grey, fontWeight: FontWeight.bold),
      timeTextStyle: const TextStyle(
          color: AppColors.secondaryColor,
          fontSize: 24,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold),
      activeTimeTextStyle: const TextStyle(
          color: AppColors.secondaryColor,
          fontSize: 26,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold),
    );

    if (result != null) {
      setState(() {
        _startTime = result.startTime;
        _endTime = result.endTime;

        widget.startTime = _startTime!;
        widget.endTime = _endTime!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Header
          Text(
            "Select Time Range",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 20),

          // Row displaying FROM and TO times
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      "FROM: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _startTime?.format(context) ?? "--:--",
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.access_time, color: Colors.grey),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "TO: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _endTime?.format(context) ?? "--:--",
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.access_time, color: Colors.grey),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Change Time Range button
          ElevatedButton(
            onPressed: _pickTimeRange,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              backgroundColor: AppColors.secondaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text("Change Time Range",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
