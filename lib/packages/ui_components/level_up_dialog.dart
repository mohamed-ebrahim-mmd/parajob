import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/gradient_progress_bar.dart';
import 'package:para_job/res/app_asset_paths.dart';

Future<void> showLevelUpDialog(
  BuildContext context, {
  required String xp,
  required double xpProgress,
  required int level,
}) async {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        backgroundColor: AppColors.dialogBackgroundDark,
        insetPadding: EdgeInsets.symmetric(horizontal: context.wPct(5)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.wPct(5)),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(context.wPct(6)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Header with Close Icon
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(
                      Icons.cancel_outlined,
                      color: AppColors.pureWhite,
                      size: context.wPct(8),
                    ),
                  ),
                ),

                /// Trophy Image
                SvgPicture.asset(
                  AppAssetPaths.levelUpTrophy,
                  width: context.wPct(35),
                  height: context.wPct(35),
                ),
                context.hBox(2),

                /// Level Number and Text
                Text(
                  "level_up_you_are_now_on".tr,
                  style: TextStyle(
                    color: AppColors.gray8D,
                    fontSize: context.wPct(4.5),
                  ),
                ),
                context.hBox(1),
                Text(
                  "$level",
                  style: TextStyle(
                    color: AppColors.pureWhite,
                    fontSize: context.wPct(10),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                context.hBox(1),

                /// XP Progress Bar with Badge
                Row(
                  children: [
                    Text(
                      xp,
                      style: TextStyle(
                        color: AppColors.aquaTeal,
                        fontSize: context.wPct(3.5),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    context.wBox(2),
                    Expanded(
                      child: Center(
                        child: GradientProgressBar(percentage: xpProgress),
                      ),
                    ),
                    context.wBox(2),
                    Positioned(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SvgPicture.asset(
                            AppAssetPaths.icLevelBadgeNext,
                            width: context.wPct(11),
                            height: context.wPct(11),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: context.wPct(4)),
                            child: Text(
                              "${level + 1}",
                              style: TextStyle(
                                color: AppColors.pureWhite,
                                fontSize: context.wPct(3),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                context.hBox(6),

                /// "How to level up?" Section
                SectionWidget(
                  title: "level_up_how_to".tr,
                  content: [
                    "level_up_how_1".tr,
                    "level_up_how_2".tr,
                    "level_up_how_3".tr,
                    "level_up_how_4".tr,
                    "level_up_how_5".tr,
                  ],
                ),
                context.hBox(4),

                /// "Why to level up?" Section
                SectionWidget(
                  title: "level_up_why_to".tr,
                  content: [
                    "level_up_why_1".tr,
                    "level_up_why_2".tr,
                    "level_up_why_3".tr,
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class SectionWidget extends StatelessWidget {
  final String title;
  final List<String> content;

  const SectionWidget({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColors.pureWhite,
            fontSize: context.wPct(5),
            fontWeight: FontWeight.bold,
          ),
        ),
        context.hBox(1.5),
        ...content.map(
          (item) => Padding(
            padding: EdgeInsets.only(bottom: context.wPct(0.5)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "⬤  ",
                  style: TextStyle(
                    color: AppColors.gray8D,
                    fontSize: context.wPct(3),
                  ),
                ),
                Expanded(
                  child: Text(
                    item,
                    style: TextStyle(
                      color: AppColors.almostWhite,
                      fontSize: context.wPct(4),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
