/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-13 11:11 AM
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:para_job/res/app_asset_paths.dart';

class OnboardingView3 extends StatelessWidget {
  const OnboardingView3({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          AppAssetPaths.onboardingScreenBackground3,
          fit: BoxFit.cover,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Text(
              'Let’s get started!',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
