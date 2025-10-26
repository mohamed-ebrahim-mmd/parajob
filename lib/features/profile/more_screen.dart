import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/res/app_asset_paths.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new), // Or your custom icon
          onPressed: () {
            Navigator.of(context).pop(); // Handle back action
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.wPct(5),
            vertical: context.hPct(2),
          ),
          child: ListView(
            children: [
              // ===== Account Section =====
              Text(
                "Account",
                style: TextStyle(
                  color: AppColors.softWhite70,
                  fontSize: context.wPct(5),
                  fontWeight: FontWeight.w600,
                ),
              ),
              context.hBox(2),

              CustomListTile(
                icon: AppAssetPaths.profilrIcon,
                title: "Edit Personal Info",
                onTap: () {
                  // navigate to Edit Info Screen
                },
              ),
              context.hBox(1.5),

              CustomListTile(
                icon: AppAssetPaths.lock,
                title: "Change Password",
                onTap: () {
                  // navigate to Change Password Screen
                },
              ),
              context.hBox(1.5),

              CustomListTile(
                icon: AppAssetPaths.changeNum,
                title: "Change Number",
                onTap: () {
                  // open Change Number flow
                },
              ),
              context.hBox(1.5),

              CustomListTile(
                icon: AppAssetPaths.deleteAcc,
                title: "Delete Account",
                isRedTitle: true,
                onTap: () {
                  // handle delete account
                },
              ),
              context.hBox(1.5),

              CustomListTile(
                icon: AppAssetPaths.logoutIcon,
                title: "Log Out",
                isRedTitle: true,
                onTap: () {
                  // perform logout
                },
              ),

              context.hBox(3),

              // ===== Help Section =====
              Text(
                "Help",
                style: TextStyle(
                  color: AppColors.softWhite70,
                  fontSize: context.wPct(5),
                  fontWeight: FontWeight.w600,
                ),
              ),
              context.hBox(2),

              CustomListTile(
                icon: AppAssetPaths.aboutUs,
                title: "About Us",
                onTap: () {
                   Get.toNamed("${Routes.more}${Routes.aboutUs}");
                
                },
              ),
              context.hBox(1.5),

              CustomListTile(
                icon: AppAssetPaths.contactUs,
                title: "Contact Us",
                onTap: () {
                  // navigate to Contact screen
                },
              ),
              context.hBox(1.5),
              CustomListTile(
                icon: AppAssetPaths.complaint,
                title: "Complaint",
                onTap: () {
                  // navigate to Complaint form
                },
              ),
              

              
            ],
          ),
        ),
      ),
    );
  }
}


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
        borderRadius: BorderRadius.circular(12),
      ),
      leading: SvgPicture.asset(icon, width: 24, height: 24),
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
