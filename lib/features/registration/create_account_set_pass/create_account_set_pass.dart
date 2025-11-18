import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/registration/create_account_set_pass/create_account_set_pass_controller.dart';
import 'package:para_job/features/registration/widgets/stepper.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class CreateAccountSetPass extends StatelessWidget {
  final controller = Get.put(CreateAccountSetPassController());

  CreateAccountSetPass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pop();
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
              StepperRow(currentStep: 1, stepPercentage: "20%"),

              context.hBox(2),
              Text(
                'create_account_set_pass_title'.tr,
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
                    hintText: 'create_account_set_pass_password_hint'.tr,
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
                    hintText: 'create_account_set_pass_confirm_hint'.tr,
                    errorText: controller.confirmPasswordError.value,
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
          vertical: context.hPct(2.8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            FilledButton(
              onPressed: () {
                controller.validateAndSubmit(context);
              },
              child: Text('create_account_set_pass_continue_button'.tr),
            ),

            context.hBox(5),
            GestureDetector(
              child: Text(
                'create_account_set_pass_contact_us'.tr,
                style: TextStyle(
                  color: AppColors.aquaTeal,
                  fontSize: context.wPct(4.2),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
