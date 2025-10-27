import 'package:flutter/material.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class CustomListTileContactUs extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const CustomListTileContactUs({
    super.key,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      tileColor: AppColors.listTileBG,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.wPct(2)),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: AppColors.pureWhite,
          fontSize: context.wPct(4.2),
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Padding(
        padding: EdgeInsets.only(top: context.hPct(0.5)),
        child: Text(
          subtitle,
          style: TextStyle(
            color: AppColors.softWhite70,
            fontSize: context.wPct(3.5),
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
