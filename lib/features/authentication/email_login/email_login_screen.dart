/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-14 11:05 AM
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/authentication/email_login/email_login_controller.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class EmailLoginScreen extends StatelessWidget {
  final controller = Get.put(EmailLoginController());

  EmailLoginScreen({super.key});

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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.defaultPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              context.hBox(2),
              Text(
                'login_title'.tr,
                style: TextStyle(
                  color: AppColors.pureWhite,
                  fontSize: context.wPct(8.5),
                  fontWeight: FontWeight.w600,
                ),
              ),
              context.hBox(6),
              Obx(() {
                return TextField(
                  controller: controller.emailController,
                  decoration: InputDecoration(
                    hintText: 'login_email_hint'.tr,
                    errorText: controller.emailError.value,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                );
              }),
              context.hBox(1.5),
              Obx(() {
                return TextField(
                  controller: controller.passwordController,
                  decoration: InputDecoration(
                    hintText: 'login_password_hint'.tr,
                    errorText: controller.passwordError.value,
                  ),
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                );
              }),
              context.hBox(1.5),
              Align(
                alignment: AlignmentDirectional.topEnd,
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(
                      "${Routes.authChoice}${Routes.emailLoginScreen}${Routes.forgotPassword}",
                    );
                  },
                  child: Text(
                    'login_forgot_password'.tr,
                    style: TextStyle(
                      color: AppColors.pureWhite,
                      fontSize: context.wPct(4.2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.wPct(5),
          vertical: context.hPct(7),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FilledButton(
              onPressed: () {
                controller.login(context);
              },
              child: Text('login_button'.tr),
            ),
            context.hBox(4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'login_no_account'.tr,
                  style: TextStyle(
                    color: AppColors.pureWhite,
                    fontSize: context.wPct(4.2),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                context.wBox(2),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.createAccount);
                  },
                  child: Text(
                    'login_sign_up'.tr,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: AppColors.pureWhite,
                      fontSize: context.wPct(4.2),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
   
   
   
    );
  }
}
