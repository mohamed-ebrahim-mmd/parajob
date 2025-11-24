/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-13 11:11 AM
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/packages/route_manager/controller/routing_controller.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/res/app_asset_paths.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
        Positioned(
          bottom: context.hPct(10),
          left: 0,
          right: 0,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.wPct(8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // --- Onboarding Text ---
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Browe to find the',
                    style: TextStyle(
                      color: AppColors.pureWhite,
                      fontSize: context.wPct(4.5),
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(
                        text: ' perfect job',
                        style: TextStyle(color: AppColors.aquaTeal),
                      ),
                      TextSpan(text: ' for \n you.'),
                    ],
                  ),
                ),

                context.hBox(4),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnimatedSmoothIndicator(
                      activeIndex: 0,
                      count: 3,
                      effect: ExpandingDotsEffect(
                        dotHeight: 8,
                        dotWidth: 8,
                        activeDotColor: AppColors.aquaTeal,
                        dotColor: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.find<RoutingController>().goAuthChoiceScreen();
                      },
                      child: (Container(
                        padding: EdgeInsets.all(context.wPct(3)),
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            Text(
                              "skip",
                              style: TextStyle(fontSize: context.wPct(4)),
                            ),
                            context.wBox(1),
                            Icon(
                              Icons.double_arrow_rounded,
                              size: context.wPct(4),
                            ),
                          ],
                        ),
                      )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
