import 'package:flutter/material.dart';
import 'package:para_job/packages/localization_manger/controller/localization_controller.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class LanguageSwitcher extends StatelessWidget {
  final LocalizationController localizationController;

  const LanguageSwitcher({super.key, required this.localizationController});

  static final ButtonStyle _languageTextButtonStyle = TextButton.styleFrom(
    padding: EdgeInsets.zero,
    minimumSize: Size.zero,
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.ltr,
      children: [
        TextButton(
          style: _languageTextButtonStyle,
          onPressed: () {
            localizationController.changeLanguageForAuth(const Locale('en'));
          },
          child: Text(
            'EN',
            style: TextStyle(
              color: localizationController.isEnglish
                  ? AppColors.aquaTeal
                  : AppColors.lightGray,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        context.wBox(4),
        TextButton(
          style: _languageTextButtonStyle,
          onPressed: () {
            localizationController.changeLanguageForAuth(const Locale('ar'));
          },
          child: Text(
            'AR',
            style: TextStyle(
              color: !localizationController.isEnglish
                  ? AppColors.aquaTeal
                  : AppColors.lightGray,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
