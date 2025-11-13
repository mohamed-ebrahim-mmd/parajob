import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/registration/create_account_cv/create_account_cv_controller.dart';
import 'package:para_job/features/registration/widgets/file_picker.dart';
import 'package:para_job/features/registration/widgets/stepper.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class CreateAccountCvScreen extends StatelessWidget {
  final controller = Get.put(CreateAccountCvController());

  CreateAccountCvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.wPct(5)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              context.hBox(2),
              StepperRow(currentStep: 4, stepPercentage: "80%"),
              context.hBox(2),
              Text(
                'create_account_cv_title'.tr,
                style: TextStyle(
                  color: AppColors.pureWhite,
                  fontSize: context.wPct(8.5),
                  fontWeight: FontWeight.w600,
                ),
              ),
              context.hBox(0.5),
              Text(
                'create_account_cv_subtitle'.tr,
                style: TextStyle(
                  color: AppColors.softWhite70,
                  fontSize: context.wPct(3.5),
                  fontWeight: FontWeight.w500,
                ),
              ),
              context.hBox(6),
              CVUploader(onFileSelected: controller.setCvFile),
              Obx(() {
                return Visibility(
                  visible: controller.cvFileError.value != null,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: context.wPct(2),
                      top: context.hPct(1),
                    ),
                    child: Text(
                      controller.cvFileError.value ?? "",
                      style: TextStyle(
                        color: AppColors.coralRed,
                        fontSize: context.wPct(3),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.wPct(5),
          vertical: context.hPct(5),
        ),
        child: FilledButton(
          onPressed: controller.validateAndUpload,
          child: Text('create_account_cv_confirm_button'.tr),
        ),
      ),
    );
  }
}
