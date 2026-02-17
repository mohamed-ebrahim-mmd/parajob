//Mary Mark ||  mary.mark@moselaymd.com || Tue Feb 17 2026 17:10:47

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/res/app_asset_paths.dart';

class UserLevelBadge extends StatelessWidget {
  const UserLevelBadge({super.key, required this.level});

  final int? level;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(
          AppAssetPaths.icLevelBadgeCurrent,
          width: context.wPct(10),
          height: context.wPct(10),
        ),
        SizedBox(
          width: context.wPct(6),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "${(level ?? 0)}",
              style: TextStyle(
                color: AppColors.pureWhite,
                fontSize: context.wPct(4.2),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
