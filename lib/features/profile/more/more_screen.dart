import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/features/profile/more/more_controller.dart';
import 'package:para_job/features/profile/widgets/custom_list_tile.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/route_manager/controller/routing_controller.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/app_dialog.dart';
import 'package:para_job/res/app_asset_paths.dart';

class MoreScreen extends StatelessWidget {
  MoreScreen({super.key});
  final controller = Get.put(MoreController());

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
          padding: EdgeInsets.symmetric(horizontal: context.wPct(5)),
          child: ListView(
            children: [
              // ===== Account Section =====
              context.hBox(2),
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
                  showApplicationDialog(
                    message:
                        "Are you sure that you want to delete your account?",
                    textButton: "Delete my account",
                    warning:
                        "Warning: if you deleted your account you will lose all your data and your level rank.",
                    context: context,
                    onTap: () {
                      Navigator.of(context).pop();
                     controller.deleteUserAccount(context);

                    },
                  );
                },
              ),
              context.hBox(1.5),

              CustomListTile(
                icon: AppAssetPaths.logoutIcon,
                title: "Log Out",
                isRedTitle: true,
                onTap: () {
                  showApplicationDialog(
                    message:
                        "Are you sure that you want to log out of your account?",
                    textButton: "Log out",
                    context: context,
                    onTap: () {
                      Get.find<RoutingController>().logOut();
                    },
                  );

                  //
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
                  Get.toNamed(
                    "${Routes.mainNavigator}${Routes.more}${Routes.aboutUs}",
                  ); //mainNavigator
                },
              ),
              context.hBox(1.5),

              CustomListTile(
                icon: AppAssetPaths.contactUs,
                title: "Contact Us",
                onTap: () {
                  Get.toNamed(
                    "${Routes.mainNavigator}${Routes.more}${Routes.contactUs}",
                  );
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

              context.hBox(2),
            ],
          ),
        ),
      ),
    );
  }
}
