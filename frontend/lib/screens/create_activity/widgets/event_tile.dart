import 'package:flutter/material.dart';
import 'package:frontend/theme/colors.dart';

class EventTile extends StatelessWidget {
  final String title, imgPath;

  const EventTile({
    super.key,
    required this.title,
    required this.imgPath,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      double width = constraints.maxWidth;
      double height = constraints.maxHeight;
      double textHeight = height / 3;
      double imgHeight = height - textHeight;
      return Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceColor,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: const Color.fromARGB(255, 217, 217, 217),
            width: 1.0,
          ),
        ),
        child: Column(
          children: [
            Flexible(
              flex: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
                child: Image.asset(
                  imgPath,
                  height: imgHeight,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(8, (textHeight - 12) / 3, 0, 0),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
