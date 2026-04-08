import 'package:flutter/material.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class EmployerStatBox extends StatelessWidget {
  final String title;
  final String value;

  const EmployerStatBox({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: context.wPct(1)),
        padding: EdgeInsets.symmetric(vertical: context.hPct(2)),
        decoration: BoxDecoration(
          color: AppColors.white5,
          borderRadius: BorderRadius.circular(context.wPct(3)),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: context.wPct(3.5),
                fontWeight: FontWeight.w600,
                color: AppColors.pureWhite,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: context.wPct(8),
                fontWeight: FontWeight.w500,
                color: AppColors.pureWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
