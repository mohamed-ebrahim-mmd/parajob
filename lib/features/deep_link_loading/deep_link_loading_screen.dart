// Karim Toson || kareemtoson1@gmail.com || 23/11/2025 9:41AM
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/deep_link_loading/deep_link_loading_controller.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class DeepLinkLoadingScreen extends StatelessWidget {
  DeepLinkLoadingScreen({super.key});

  final controller = Get.put(DeepLinkLoadingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.charcoalBlack,
      body: Center(
        child: Image.asset(
          'assets/icons/parajobIcon.png',
          width: context.wPct(40),
          height: context.wPct(40),
        ),
      ),
    );
  }
}
