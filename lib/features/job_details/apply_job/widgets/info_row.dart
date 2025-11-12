/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 11/11/2025 3:36 PM
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:para_job/packages/themeing/app_colors.dart' show AppColors;
import 'package:para_job/packages/themeing/media_query_values.dart';

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.hPct(1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            maxLines: 1,
            style: TextStyle(
              color: AppColors.white60,
              fontSize: context.wPct(3.5),
              fontWeight: FontWeight.w400,
            ),
          ),
           SizedBox(height: context.hPct(0.5)),
          Text(
            value,
            maxLines: 1,
            style:  TextStyle(
              color: AppColors.pureWhite,
              fontWeight: FontWeight.w500,
              fontSize: context.wPct(4),
            ),
          ),
        ],
      ),
    );
  }
}
