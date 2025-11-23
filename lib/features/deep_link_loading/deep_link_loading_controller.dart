// Karim Toson || kareemtoson1@gmail.com || 23/11/2025 9:40AM

import 'package:get/get.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

class DeepLinkLoadingController extends GetxController {
  @override
  void onReady() {
    super.onReady();

    // Delay to avoid GlobalKey conflicts
    Future.delayed(const Duration(milliseconds: 500), () {
      _handleDeepLink();
    });
  }

  void _handleDeepLink() async {
    final jobIdString = Get.parameters['id'];

    // ❗ no ID in the deep link → send user to Home
    if (jobIdString == null) {
      Get.offAllNamed(Routes.mainNavigator);
      return;
    }

    // ❗ ID not a valid number
    final jobId = int.tryParse(jobIdString);
    if (jobId == null) {
      Get.offAllNamed(Routes.mainNavigator);
      return;
    }

    final userController = Get.find<UserController>();

    // 👤 Guest user → go to Auth screen THEN push job details
    if (userController.isGuest) {
      Get.offAllNamed(Routes.authChoice);
      Get.toNamed(Routes.jobDetails, arguments: jobId);
      return;
    }

    // 👤 Logged-in user → go to Home THEN push job details
    await Get.offAllNamed(Routes.mainNavigator);
    Get.toNamed(Routes.jobDetails, arguments: jobId);
  }
}
