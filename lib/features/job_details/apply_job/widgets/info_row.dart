/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 11/11/2025 3:36 PM
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:para_job/packages/themeing/app_colors.dart' show AppColors;

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            maxLines: 1,
            style: const TextStyle(
              color: AppColors.white60,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            maxLines: 1,
            style: const TextStyle(
              color: AppColors.pureWhite,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
