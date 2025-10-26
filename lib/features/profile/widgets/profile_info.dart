import 'package:flutter/material.dart';
import 'package:para_job/packages/api_client/src/models/responses/user_profile_data.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/custom_container_company_details.dart';
import 'package:para_job/packages/ui_components/custom_gradient_progress.dart';

class UserProfileInfo extends StatelessWidget {
  const UserProfileInfo({super.key, required this.profileData});

  final UserProfileData profileData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: context.wPct(15),
          backgroundColor: AppColors.aquaTeal,
          child: ClipOval(
            child: Image.network(
              profileData.profilePicture ?? '',
              fit: BoxFit.cover,
              width: context.wPct(28),
              height: context.wPct(28),

              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                );
              },

              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.person, size: 40, color: Colors.grey);
              },
            ),
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
        //progress par
        Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: context.wPct(10)),
          child: Row(
            children: [
              Text(
                "${profileData.name} ",
                style: TextStyle(
                  color: AppColors.aquaTeal,
                  fontSize: context.wPct(4),
                  fontWeight: FontWeight.w500,
                ),
              ),
              context.wBox(3),
              Flexible(child: GradientProgressBar(percentage: 100)),
            ],
          ),
        ),
        context.hBox(3),
        // Stats
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomContainerCompanyDetail(
                value: formatNumber(
                  profileData.jobsCount ?? 0,
                ), //profileData.jobsCount?.toString() ?? "0",
                title: "JOBS",
              ),
            ),
            context.wBox(2),
            Expanded(
              child: CustomContainerCompanyDetail(
                value: formatNumber(
                  num.parse(profileData.income ?? "0"),
                ), // profileData.income?.toString() ?? "0",
                title: "INCOME",
              ),
            ),
            context.wBox(2),
            Expanded(
              child: CustomContainerCompanyDetail(
                value: formatNumber(
                  profileData.companiesCount ?? 0,
                ), //profileData.companiesCount?.toString() ?? "0",
                title: "COMPANIES",
              ),
            ),
          ],
        ),
      ],
    );
  }
}

String formatNumber(num number) {
  if (number >= 1000000000) {
    return "${_trimZeros((number / 1000000000).toStringAsFixed(1))}B";
  } else if (number >= 1000000) {
    return _trimZeros((number / 1000000).toStringAsFixed(1)) + "M";
  } else if (number >= 1000) {
    return _trimZeros((number / 1000).toStringAsFixed(1)) + "K";
  } else {
    return _trimZeros(number.toStringAsFixed(0));
  }
}

String _trimZeros(String value) {
  // Removes ".0" at the end
  if (value.endsWith('.0')) {
    return value.substring(0, value.length - 2);
  }
  return value;
}
