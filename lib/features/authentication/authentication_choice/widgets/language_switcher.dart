import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/packages/localization_manger/controller/localization_controller.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});
  static final LocalizationController _localizationController =
      Get.find<LocalizationController>();

  @override
  Widget build(BuildContext context) {
    //  style for the buttons
    ButtonStyle languageTextButtonStyle(bool isSelected) =>
        TextButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: context.wPct(2.3),
            vertical: context.hPct(0.5),
          ),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        );

    // TextStyle for the text
    TextStyle textStyle(bool isSelected) => TextStyle(
      color: isSelected ? AppColors.aquaTeal : AppColors.lightGray,
      fontWeight: FontWeight.bold,
      fontSize: context.wPct(3.4),
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(context.wPct(6)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 35, sigmaY: 35),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.17),

            borderRadius: BorderRadius.circular(context.wPct(6)),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: context.wPct(0.4),
            ),
          ),
          padding: EdgeInsets.all(context.wPct(0.5)),
          child: Row(
            mainAxisSize: MainAxisSize.min, // Take only necessary space
            textDirection: TextDirection.ltr,
            children: [
              // EN Button
              TextButton(
                style: languageTextButtonStyle(
                  _localizationController.isEnglish,
                ),
                onPressed: () {
                  _localizationController.changeLanguageForAuth(
                    const Locale('en'),
                  );
                },
                child: Text(
                  'EN',
                  style: textStyle(_localizationController.isEnglish),
                ),
              ),

              // Divider in the middle
              Container(
                height: context.hPct(2.2),
                width: 1.5,
                color: AppColors.lightGray.withOpacity(0.5),
                margin: const EdgeInsets.symmetric(horizontal: 4),
              ),

              // AR Button
              TextButton(
                style: languageTextButtonStyle(
                  !_localizationController.isEnglish,
                ),
                onPressed: () {
                  _localizationController.changeLanguageForAuth(
                    const Locale('ar'),
                  );
                },
                child: Text(
                  'AR',
                  style: textStyle(!_localizationController.isEnglish),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
