
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/res/app_asset_paths.dart';

class RegisterNote extends StatelessWidget {
  const RegisterNote({super.key, required this.note});
  final String note;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(AppAssetPaths.checkIcon),
        context.wBox(2),
        Text(
          note,
          style: TextStyle(
            color: AppColors.softWhite70,
            fontSize: context.wPct(3.5),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
