/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2024-12-23 4:45 PM
 ==================================================================
*/

import 'package:flutter/material.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

import 'app_colors.dart';

class AppTheme {
  static Color shimmerBaseColor = Colors.grey.shade300;
  static Color shimmerHighlightColor = Colors.grey.shade100;

  static ThemeData getTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.charcoalBlack,
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.aquaTeal,
        onPrimary: AppColors.pureWhite,
        secondary: AppColors.aquaTeal,
        onSecondary: AppColors.pureWhite,
        error: AppColors.coralRed,
        onError: AppColors.pureWhite,
        surface: AppColors.charcoalBlack,
        onSurface: AppColors.pureWhite,
      ),
      textTheme: TextTheme(
        bodyMedium: TextStyle(color: AppColors.pureWhite),
        bodySmall: TextStyle(
          fontSize: context.wPct(2),
          color: AppColors.pureWhite, // Subtext colo, // Subtext color
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          side:
           WidgetStateProperty.all(
            BorderSide(color: AppColors.pureWhite, width: 1.5),
          ),
          shape:
           WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                context.wPct(4),
              ), 
            ),
          ),
          minimumSize: WidgetStateProperty.all(
             Size(context.w, context.hPct(8)),
          ),
         
          padding: WidgetStateProperty.all(
            EdgeInsets.symmetric(horizontal: context.wPct(9)),
          ),

          foregroundColor: WidgetStateProperty.all(
            AppColors.pureWhite,
          ), // Text/Icon color
          textStyle: WidgetStateProperty.all(
            TextStyle(fontSize: context.wPct(4.8), fontWeight: FontWeight.bold),
          ),
        ),
      ),
      
      /*
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          elevation: WidgetStateProperty.all(0),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                context.wPct(7),
              ), // Optional: rounded corners
            ),
          ),
          fixedSize: WidgetStateProperty.all(
            Size.fromHeight(context.hPct(7)),
          ), // Replace 56 with your height
          padding: WidgetStateProperty.all(
            EdgeInsets.symmetric(horizontal: context.wPct(9)),
          ),

          foregroundColor: WidgetStateProperty.all(
            AppColors.crystalClear,
          ), // Text/Icon color
          textStyle: WidgetStateProperty.all(
            TextStyle(fontSize: context.wPct(4.8), fontWeight: FontWeight.bold),
          ),
        ),
      ),
*/
    );
  }
}
