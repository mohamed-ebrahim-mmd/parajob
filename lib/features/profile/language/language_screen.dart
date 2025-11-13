//Mary Mark ||  mary.mark@moselaymd.com || Thu Nov 13 2025 12:50:38

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/packages/localization_manger/controller/localization_controller.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class LanguageScreen extends StatelessWidget {
  final LocalizationController localizationController =
      Get.find<LocalizationController>();

  LanguageScreen({super.key});

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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('onboarding_title'.tr, style: TextStyle(fontSize: 20)),

              const SizedBox(height: 20),
              // Radio button for English
              RadioListTile<Locale>(
                title: const Text('English'),
                value: const Locale('en'),
                groupValue: localizationController.currentLocale,
                // Normalize comparison
                onChanged: localizationController.changeLanguage,
              ),
              // Radio button for Arabic
              RadioListTile<Locale>(
                title: const Text('العربية'),
                value: const Locale('ar'),
                groupValue: localizationController.currentLocale,
                // Normalize comparison
                onChanged: localizationController.changeLanguage,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
