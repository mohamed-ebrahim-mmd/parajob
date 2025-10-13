/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-13 11:11 AM
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
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
        Positioned(
          bottom: context.hPct(10),
          left: 0,
          right: 0,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.wPct(5)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // --- Onboarding Text ---
                const Text(
                  'Welcome to our app!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
