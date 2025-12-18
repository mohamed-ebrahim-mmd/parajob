import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:para_job/features/profile/user_profile/profile_controller.dart'
    show ProfileController;
import 'package:para_job/features/profile/widgets/show_edit_photo_buttom_sheet.dart';
import 'package:para_job/packages/api_client/src/models/responses/user_profile_data.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/company_detail_container.dart';
import 'package:para_job/packages/ui_components/gradient_progress_bar.dart';
import 'package:para_job/res/app_asset_paths.dart';

class UserProfileInfo extends StatelessWidget {
  const UserProfileInfo({
    super.key,
    required this.profileData,
    required this.controller,
  });

  final UserProfileData profileData;
  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            await showEditPhotoBottomSheet(context, controller);
          },
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              /// Avatar
              CircleAvatar(
                radius: context.wPct(15),
                backgroundColor:
                    (profileData.profilePicture != null &&
                        profileData.profilePicture != "")
                    ? AppColors.aquaTeal
                    : AppColors.lightGray2,
                child: ClipOval(
                  child: Image.network(
                    profileData.profilePicture ?? '',
                    fit: BoxFit.cover,
                    width: context.wPct(28),
                    height: context.wPct(28),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          strokeWidth: context.wPct(1),
                          color: AppColors.lightGrey,
                        ),
                      );
                    },
                    errorBuilder: (_, __, ___) => Icon(
                      Icons.image_not_supported_rounded,
                      size: context.wPct(15),
                      color: AppColors.lightGrey,
                    ),
                  ),
                ),
              ),

              /// Level Badge
              Positioned(
                bottom: -context.wPct(4),

                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(
                      AppAssetPaths.levelBadge,
                      width: context.wPct(10),
                      height: context.wPct(10),
                    ),
                    SizedBox(
                      width: context.wPct(6),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "${(profileData.level ?? 0)}",
                          style: TextStyle(
                            color: AppColors.pureWhite,
                            fontSize: context.wPct(4.5),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        ///
        ///name
        context.hBox(3),
        Text(
          profileData.name ?? "",
          style: TextStyle(
            color: AppColors.pureWhite,
            fontSize: context.wPct(5),
            fontWeight: FontWeight.w600,
          ),
        ),
        context.hBox(3),
        // XP and Level display
        Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: context.wPct(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                " ${profileData.xp ?? 0}",
                style: TextStyle(
                  color: AppColors.aquaTeal,
                  fontSize: context.wPct(4),
                  fontWeight: FontWeight.w500,
                ),
              ),
              context.wBox(2),
              // Progress Bar usnig xp for 3000
              Flexible(
                child: GradientProgressBar(
                  percentage: ((profileData.xp ?? 0) / 3000) * 100,
                ),
              ),

              context.wBox(2),
              Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset(
                    AppAssetPaths.levelBadge2,
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
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "${(profileData.level ?? 0) + 1}",
                          style: TextStyle(
                            color: AppColors.pureWhite,
                            fontSize: context.wPct(4),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        context.hBox(3),
        // Stats
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CompanyDetailContainer(
                value: controller.formatNumber(profileData.jobsCount ?? 0),
                title: 'profile_info_jobs'.tr,
              ),
            ),
            context.wBox(2),
            Expanded(
              child: CompanyDetailContainer(
                value: controller.formatNumber(
                  num.tryParse(profileData.income ?? "0") ?? 0,
                ),
                title: 'profile_info_income'.tr,
              ),
            ),
            context.wBox(2),
            Expanded(
              child: CompanyDetailContainer(
                value: controller.formatNumber(
                  num.tryParse(profileData.companiesCount ?? "0") ?? 0,
                ),
                title: 'profile_info_companies'.tr,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
