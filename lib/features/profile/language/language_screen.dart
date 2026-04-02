//Mary Mark ||  mary.mark@moselaymd.com || Thu Nov 13 2025 12:50:38

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/profile/language/widgets/language_tile.dart';
import 'package:para_job/packages/localization_manger/controller/localization_controller.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/res/app_asset_paths.dart';

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
        padding: EdgeInsets.symmetric(horizontal: context.defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            context.hBox(3),

            Text(
              'language'.tr,
              style: TextStyle(
                fontSize: context.wPct(6),
                fontWeight: FontWeight.bold,
                color: AppColors.softWhite70,
              ),
            ),

            context.hBox(3),
            // Radio button for English
            LanguageTile(
              title: "English",
              flagAsset: AppAssetPaths.english,
              value: const Locale('en'),
              groupValue: localizationController.currentLocale,
              onChanged: localizationController.changeLanguage,
            ),

            // Radio button for Arabic
            LanguageTile(
              title: 'عربى',
              flagAsset: AppAssetPaths.arab,
              value: const Locale('ar'),
              groupValue: localizationController.currentLocale,
              onChanged: localizationController.changeLanguage,
            ),
          ],
        ),
      ),
    );
  }
}
