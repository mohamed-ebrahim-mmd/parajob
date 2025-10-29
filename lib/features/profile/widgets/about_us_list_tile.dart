import 'package:flutter/material.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class AboutUsListTile extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const AboutUsListTile({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      tileColor: AppColors.listTileBG,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.wPct(2)),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        color: AppColors.pureWhite,
      ),

      title: Text(
        title,
        style: TextStyle(
          color: AppColors.pureWhite,
          fontSize: context.wPct(4),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
