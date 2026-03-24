/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 21/12/2025 4:16 PM
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/gradient_progress_bar.dart';
import 'package:para_job/packages/ui_components/level_up_dialog.dart';
import 'package:para_job/res/app_asset_paths.dart';

class XpLevelIndicator extends StatelessWidget {
  const XpLevelIndicator({
    super.key,
    required this.xp,
    required this.level,
    required this.xpProgress,
  });

  final double xpProgress;

  final int xp;
  final int level;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.wPct(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            " $xp",
            style: TextStyle(
              color: AppColors.aquaTeal,
              fontSize: context.wPct(4),
              fontWeight: FontWeight.w500,
            ),
          ),
          context.wBox(2),
          // Progress Bar using xp for the next level
          Flexible(child: GradientProgressBar(percentage: xpProgress)),
          context.wBox(2),
          GestureDetector(
            onTap: () {
              showLevelUpDialog(
                context,
                xp: "${(xpProgress * 100).toInt()}%".toString(),
                xpProgress: xpProgress,
                level: level,
              );
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  AppAssetPaths.icLevelBadgeNext,
                  width: context.wPct(15),
                  height: context.wPct(15),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: context.wPct(5),
                    right: context.wPct(0.5),
                  ),
                  child: SizedBox(
                    width: context.wPct(8),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.wPct(1),
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "${level + 1}",
                          style: TextStyle(
                            color: AppColors.pureWhite,
                            fontSize: context.wPct(3.5),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
