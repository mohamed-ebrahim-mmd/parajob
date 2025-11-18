import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/profile/widgets/about_us_list_tile.dart';
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
          padding: EdgeInsets.symmetric(horizontal: context.defaultPadding),
          child: ListView(
            children: [
              context.hBox(2),
              // ===== Account Section =====
              AboutUsListTile(
                title: 'about_us_about_app'.tr,
                onTap: () {
                  Get.toNamed(
                    "${Routes.mainNavigator}${Routes.more}${Routes.aboutUs}${Routes.aboutApp}",
                  );
                },
              ),
              context.hBox(1.5),

              AboutUsListTile(
                title: 'about_us_rate_app'.tr,
                onTap: () {
                  // navigate to Change Password Screen
                },
              ),
              context.hBox(1.5),

              AboutUsListTile(
                title: 'about_us_instagram'.tr,
                onTap: () {
                  // open Change Number flow
                },
              ),
              context.hBox(1.5),
              AboutUsListTile(
                title: 'about_us_twitter'.tr,
                onTap: () {
                  // open Change Number flow
                },
              ),
              context.hBox(1.5),
              AboutUsListTile(
                title: 'about_us_facebook'.tr,
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
