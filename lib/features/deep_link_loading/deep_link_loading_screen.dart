// Karim Toson || kareemtoson1@gmail.com || 23/11/2025 9:41AM
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/res/app_asset_paths.dart';

class DeepLinkLoadingScreen extends StatefulWidget {
  const DeepLinkLoadingScreen({super.key});

  @override
  State<DeepLinkLoadingScreen> createState() => _DeepLinkLoadingScreenState();
}

class _DeepLinkLoadingScreenState extends State<DeepLinkLoadingScreen> {
  @override
  void initState() {
    super.initState();

    // Schedule navigation right after the first frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final argumentsToSend = {'isDeepLink': true};
      Get.offAllNamed(Routes.mainNavigator, arguments: argumentsToSend);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black80,
      body: Center(
        child: Image.asset(
          AppAssetPaths.parajobDeepLinkLogo,
          width: context.wPct(40),
          height: context.wPct(40),
        ),
      ),
    );
  }
}
