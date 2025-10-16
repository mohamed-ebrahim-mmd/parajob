/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-16 10:13 AM
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class ErrorScreen extends StatelessWidget {
  final VoidCallback onPressed;
  final String? message;
  final double? height;

  const ErrorScreen({
    super.key,
    required this.onPressed,
    this.message,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.wifi_off_outlined,
            size: context.hPct(12),
            color: AppColors.softWhite70,
          ),
          context.hBox(2),
          Text(
            message ??
                "Failed to load data.\nPlease check your internet connection.",
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.softWhite70),
          ),
          context.hBox(3),
          ElevatedButton.icon(
            style: ButtonStyle(
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(context.wPct(4)),
                ),
              ),
              backgroundColor: WidgetStateProperty.all(AppColors.aquaTeal),
              foregroundColor: WidgetStateProperty.all(
                AppColors.pureWhite,
              ), // Text/Icon color
              textStyle: WidgetStateProperty.all(
                TextStyle(
                  fontSize: context.wPct(4.8),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            onPressed: onPressed,
            icon: const Icon(Icons.refresh),
            label: const Text("Retry"),
          ),
        ],
      ),
    );
  }
}
