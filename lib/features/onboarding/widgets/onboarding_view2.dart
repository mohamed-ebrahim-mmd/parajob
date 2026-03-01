/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-13 11:11 AM
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/res/app_asset_paths.dart';

class OnboardingView2 extends StatelessWidget {
  final double offset;
  final double opacity;

  const OnboardingView2({
    super.key,

    required this.offset,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Transform.translate(
          offset: Offset(offset, 0),
          child: Opacity(
            opacity: opacity,
            child: Align(
              alignment: Alignment.center,
              child: Image.asset(
                AppAssetPaths.centerOnboardingScreen,
                height: context.hPct(60),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
