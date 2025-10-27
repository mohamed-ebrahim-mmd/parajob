import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class CustomListTile extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback? onTap;
  final bool isRedTitle;

  const CustomListTile({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.isRedTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      tileColor: AppColors.listTileBG,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.wPct(2)),
      ),
      leading: SvgPicture.asset(
        icon,
        width: context.wPct(6),
        height: context.hPct(4),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isRedTitle ? AppColors.coralRed : AppColors.pureWhite,
          fontSize: context.wPct(4),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
