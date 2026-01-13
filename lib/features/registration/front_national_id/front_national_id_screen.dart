import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/registration/front_national_id/front_national_id_controller.dart';
import 'package:para_job/features/registration/widgets/id_img_picker.dart';
import 'package:para_job/features/registration/widgets/registration_note.dart';
import 'package:para_job/features/registration/widgets/stepper.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/res/app_asset_paths.dart';

class FrontNationalIdScreen extends StatelessWidget {
  final tempToken = Get.arguments['tempToken'];
  late final controller = Get.put(
    FrontNationalIdController(tempToken: tempToken),
  );

  FrontNationalIdScreen({super.key});

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
              StepperRow(currentStep: 2, stepPercentage: "40%"),

              context.hBox(2),
              Text(
                'front_national_id_title'.tr,
                style: TextStyle(
                  color: AppColors.pureWhite,
                  fontSize: context.wPct(8.5),
                  fontWeight: FontWeight.w600,
                ),
              ),
              context.hBox(0.5),
              Text(
                'front_national_id_subtitle'.tr,
                style: TextStyle(
                  color: AppColors.softWhite70,
                  fontSize: context.wPct(3.5),
                  fontWeight: FontWeight.w500,
                ),
              ),

              context.hBox(6),
              IdImagePicker(
                imagePath: AppAssetPaths.nationalID,
                text: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'front_national_id_scan_text_1'.tr,
                    style: TextStyle(
                      color: AppColors.softWhite70,
                      fontSize: context.wPct(4),
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        text: 'front_national_id_scan_text_front'.tr,
                        style: TextStyle(color: AppColors.aquaTeal),
                      ),
                      TextSpan(text: 'front_national_id_scan_text_2'.tr),
                    ],
                  ),
                ),
                onImageSelected: controller.setFrontIdImage,
              ),
              Obx(() {
                return Visibility(
                  visible: controller.idError.value != null,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: context.wPct(2),
                      top: context.hPct(1),
                    ),
                    child: Text(
                      controller.idError.value ?? "",
                      style: TextStyle(
                        color: AppColors.coralRed,
                        fontSize: context.wPct(3),
                      ),
                    ),
                  ),
                );
              }),
              context.hBox(2),
              RegisterNote(note: 'front_national_id_note_1'.tr),
              context.hBox(2),
              RegisterNote(note: 'front_national_id_note_2'.tr),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.wPct(5),
          vertical: context.hPct(5),
        ),
        child: Obx(() {
          return FilledButton(
            onPressed: controller.isFrontIdValid
                ? controller.validateAndContinue
                : null,
            child: Text('front_national_id_confirm_button'.tr),
          );
        }),
      ),
    );
  }
}
