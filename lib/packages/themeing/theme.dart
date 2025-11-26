/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2024-12-23 4:45 PM
 ==================================================================
*/

import 'package:flutter/material.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:pinput/pinput.dart';

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
        headlineLarge: TextStyle(
          color: AppColors.pureWhite,
          fontSize: context.wPct(3.8),
          fontWeight: FontWeight.w600,
        ),
        headlineMedium: TextStyle(
          color: AppColors.white50,
          fontSize: context.wPct(3.8),
          fontWeight: FontWeight.w400,
        ),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: AppColors.pureWhite, size: 26),
      ),
      // Disable hover for NavigationBar
      splashColor: Colors.transparent,

      inputDecorationTheme: InputDecorationTheme(
        // Border styling
        suffixIconColor: AppColors.softWhite70,
        prefixIconColor: AppColors.softWhite70,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.pureWhite,
            // width:context.wPct(4),
          ),
          borderRadius: BorderRadius.circular(context.wPct(4)),
        ),

        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.lightGrey,
            // width:context.wPct(4),
          ),
          borderRadius: BorderRadius.circular(context.wPct(4)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.aquaTeal,
            // width: 1.5,
          ),
          borderRadius: BorderRadius.circular(context.wPct(4)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.coralRed,
            // width: 1.5
          ),
          borderRadius: BorderRadius.circular(context.wPct(4)),
        ),
        errorMaxLines: 2,
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.coralRed,
            // width: 1.5
          ),
          borderRadius: BorderRadius.circular(context.wPct(4)),
        ),
        // Padding inside the field
        contentPadding: EdgeInsets.symmetric(
          horizontal: context.wPct(5),
          vertical: context.hPct(2),
        ),

        // Text style inside the input
        hintStyle: TextStyle(
          color: AppColors.softWhite70, // Hint text
          fontSize: context.wPct(4.8),
          fontWeight: FontWeight.w500,
        ),
        errorStyle: TextStyle(
          color: AppColors.coralRed, // Hint text
          fontSize: context.wPct(3),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          side: WidgetStateProperty.all(BorderSide(color: AppColors.pureWhite)),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(context.wPct(4)),
            ),
          ),
          minimumSize: WidgetStateProperty.all(
            Size(context.w, context.hPct(7)),
          ),

          padding: WidgetStateProperty.all(
            EdgeInsets.symmetric(horizontal: context.wPct(9)),
          ),

          foregroundColor: WidgetStateProperty.all(AppColors.pureWhite),
          // Text/Icon color
          textStyle: WidgetStateProperty.all(
            TextStyle(fontSize: context.wPct(4.8), fontWeight: FontWeight.bold),
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          elevation: WidgetStateProperty.all(0),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(context.wPct(4)),
            ),
          ),
          minimumSize: WidgetStateProperty.all(
            Size(context.w, context.hPct(7)),
          ),

          foregroundColor: WidgetStateProperty.all(AppColors.pureWhite),
          // Text/Icon color
          textStyle: WidgetStateProperty.all(
            TextStyle(
              fontSize: context.wPct(4.8),
              fontWeight: FontWeight.w500,
              color: AppColors.pureWhite,
            ),
          ),
        ),
      ),
    );
  }

  static PinTheme pinTheme(BuildContext context) {
    return PinTheme(
      width: context.wPct(16),
      height: context.hPct(8),
      textStyle: TextStyle(
        fontSize: context.wPct(6),
        color: AppColors.pureWhite,
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.pureWhite, width: 2),
        ),
      ),
    );
  }
}
