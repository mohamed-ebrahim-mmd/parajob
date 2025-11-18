import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
          padding: EdgeInsets.symmetric(horizontal: context.defaultPadding),
          child: ListView(
            children: [
              Text(
                'more_settings_title'.tr,
                style: TextStyle(
                  color: AppColors.softWhite70,
                  fontSize: context.wPct(5),
                  fontWeight: FontWeight.w600,
                ),
              ),
              context.hBox(2),

              CustomListTile(
                icon: AppAssetPaths.lan,
                title: 'more_language'.tr,

                onTap: () => controller.navigateTo(Routes.languageScreen),
              ),
              context.hBox(3),
              // ===== Account Section =====
              context.hBox(2),
              Text(
                'more_account_title'.tr,
                style: TextStyle(
                  color: AppColors.softWhite70,
                  fontSize: context.wPct(5),
                  fontWeight: FontWeight.w600,
                ),
              ),
              context.hBox(2),

              CustomListTile(
                icon: AppAssetPaths.profilrIcon,
                title: 'more_edit_personal_info'.tr,

                onTap: () => controller.navigateTo(Routes.editProfile),
              ),
              context.hBox(1.5),

              CustomListTile(
                icon: AppAssetPaths.lock,
                title: 'more_change_password'.tr,
                onTap: () => controller.sendChangePassRequest(context),
              ),

              context.hBox(1.5),

              CustomListTile(
                icon: AppAssetPaths.deleteAcc,
                title: 'more_delete_account'.tr,
                isRedTitle: true,
                onTap: () {
                  showApplicationDialog(
                    message: 'more_delete_account_confirmation'.tr,
                    textButton: 'more_delete_account_button'.tr,
                    warning: 'more_delete_account_warning'.tr,
                    context: context,
                    onTap: () {
                      controller.deleteUserAccount(context);
                    },
                  );
                },
              ),
              context.hBox(1.5),

              CustomListTile(
                icon: AppAssetPaths.logoutIcon,
                title: 'more_logout'.tr,
                isRedTitle: true,
                onTap: () {
                  showApplicationDialog(
                    message: 'more_logout_confirmation'.tr,
                    textButton: 'more_logout_button'.tr,
                    context: context,
                    onTap: () {
                      Get.find<RoutingController>().logOut();
                    },
                  );
                },
              ),

              context.hBox(3),

              // ===== Help Section =====
              Text(
                'more_help_title'.tr,
                style: TextStyle(
                  color: AppColors.softWhite70,
                  fontSize: context.wPct(5),
                  fontWeight: FontWeight.w600,
                ),
              ),
              context.hBox(2),

              CustomListTile(
                icon: AppAssetPaths.aboutUs,
                title: 'more_about_us'.tr,

                onTap: () => controller.navigateTo(Routes.aboutUs),
              ),
              context.hBox(1.5),

              CustomListTile(
                icon: AppAssetPaths.contactUs,
                title: 'more_contact_us'.tr,

                onTap: () => controller.navigateTo(Routes.contactUs),
              ),

              context.hBox(2),
            ],
          ),
        ),
      ),
    );
  }
}
