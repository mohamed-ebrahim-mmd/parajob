//Mary Mark ||  mary.mark@moselaymd.com || Tue Nov 11 2025 12:11:37

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/profile/change_pass/change_password/change_password_controller.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class ChangePasswordScreen extends StatelessWidget {
  final controller = Get.put(ChangePasswordController());

  ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.back();
          },
        ),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.defaultPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              context.hBox(2),
              Text(
                'change_password_title'.tr,
                style: TextStyle(
                  color: AppColors.pureWhite,
                  fontSize: context.wPct(8.5),
                  fontWeight: FontWeight.w600,
                ),
              ),
              context.hBox(6),
              Obx(() {
                return TextField(
                  controller: controller.passwordController,
                  decoration: InputDecoration(
                    hintText: 'change_password_new_hint'.tr,
                    errorText: controller.passwordError.value,
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                );
              }),
              context.hBox(1.5),
              Obx(() {
                return TextField(
                  controller: controller.confirmPasswordController,
                  decoration: InputDecoration(
                    errorText: controller.confirmPasswordError.value,
                    hintText: 'change_password_confirm_hint'.tr,
                  ),
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                );
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.wPct(5),
          vertical: context.hPct(12),
        ),
        child: FilledButton(
          onPressed: () {
            controller.validateAndSubmit(context);
          },
          child: Text('change_password_confirm_button'.tr),
        ),
      ),
    );
  }
}
