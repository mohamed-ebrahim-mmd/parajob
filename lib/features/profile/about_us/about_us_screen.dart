import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:para_job/features/profile/widgets/custom_listtile_aboutus.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
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
            
          ),
          child: ListView(
            children: [
              context.hBox(2),
              // ===== Account Section =====
              CustomListTileAboutUs(
                title: "About the application",
                onTap: () {
                  Get.toNamed("${Routes.mainNavigator}${Routes.more}${Routes.aboutUs}${Routes.aboutUsContent}");

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
              context.hBox(2),
              
            ],
          ),
        ),
      ),
    );
  }
}
