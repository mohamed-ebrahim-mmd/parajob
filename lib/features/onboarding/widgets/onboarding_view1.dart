/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-13 11:11 AM
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/packages/route_manager/controller/routing_controller.dart';
import 'package:para_job/res/app_asset_paths.dart';

class OnboardingView1 extends StatelessWidget {
  const OnboardingView1({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background image
        Image.asset(
          AppAssetPaths.onboardingScreenBackground1,
          fit: BoxFit.cover,
        ),

        // Text at the bottom
        Align(
          alignment: Alignment.bottomCenter,
          child: TextButton(
            onPressed: () {
              Get.find<RoutingController>().goAuthChoiceScreen();
            },
            child: Text('text'),
          ),
        ),
      ],
    );
  }
}
