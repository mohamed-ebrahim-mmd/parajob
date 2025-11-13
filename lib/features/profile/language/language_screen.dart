//Mary Mark ||  mary.mark@moselaymd.com || Thu Nov 13 2025 12:50:38

import 'package:flutter/material.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new), // Or your custom icon
          onPressed: () {
            Navigator.of(context).pop(); // Handle back action
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.wPct(5)),
        child: ListView(
          children: [
             Text(
                "Languages",
                style: TextStyle(
                  color: AppColors.pureWhite,
                  fontSize: context.wPct(5),
                  fontWeight: FontWeight.w600,
                ),
              ),
              context.hBox(2),
          ],
        ),
      ),
    );
  }
}
