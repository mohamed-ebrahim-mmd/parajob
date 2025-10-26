import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

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
              CustomListTileAboutUs(
                title: "About the application",
                onTap: () {
                  Get.toNamed("${Routes.more}${Routes.aboutUs}${Routes.aboutUsContent}");

                  // navigate to Edit Info Screen
                },
              ),
              context.hBox(1.5),

              CustomListTileAboutUs(
                title: "Rate us on App store",
                onTap: () {
                  // navigate to Change Password Screen
                },
              ),
              context.hBox(1.5),

              CustomListTileAboutUs(
                title: "Follow us on instagram",
                onTap: () {
                  // open Change Number flow
                },
              ),
              context.hBox(1.5),
              CustomListTileAboutUs(
                title: "Follow us on Twitter",
                onTap: () {
                  // open Change Number flow
                },
              ),
              context.hBox(1.5),
              CustomListTileAboutUs(
                title: "Like us on facebook",
                onTap: () {
                  // open Change Number flow
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomListTileAboutUs extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const CustomListTileAboutUs({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      tileColor: AppColors.listTileBG,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        color: AppColors.pureWhite,
      ),

      title: Text(
        title,
        style: TextStyle(
          color: AppColors.pureWhite,
          fontSize: context.wPct(4),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
