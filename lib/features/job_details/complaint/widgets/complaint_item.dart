/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 13/11/2025 4:25 PM
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class ComplaintItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const ComplaintItem({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(context.wPct(3)),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: context.hPct(2),
          horizontal: context.wPct(4.5),
        ),
        decoration: BoxDecoration(
          color: AppColors.white5,
          borderRadius: BorderRadius.circular(context.wPct(3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: AppColors.pureWhite,
                  fontSize: context.wPct(4),
                  fontWeight: FontWeight.w400,
                ),
                softWrap: true,
                overflow: TextOverflow.visible,
              ),
            ),
            context.wBox(1),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.pureWhite,
              size: context.wPct(5),
            ),
          ],
        ),
      ),
    );
  }
}
