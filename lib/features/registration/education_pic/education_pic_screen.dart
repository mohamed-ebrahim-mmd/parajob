import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/registration/education_pic/education_pic_controller.dart';
import 'package:para_job/features/registration/widgets/id_img_picker.dart';
import 'package:para_job/features/registration/widgets/registration_note.dart';
import 'package:para_job/features/registration/widgets/stepper.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/res/app_asset_paths.dart';

class EducationPicScreen extends StatelessWidget {
  final controller = Get.put(EducationPicController());

  EducationPicScreen({super.key});

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
        padding: EdgeInsets.symmetric(horizontal: context.defaultPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              context.hBox(2),
              StepperRow(currentStep: 3, stepPercentage: "60%"),
              //  Align(alignment: AlignmentGeometry.bottomRight, child: Text("20%")),
              context.hBox(2),
              Text(
                'education_pic_title'.tr,
                style: TextStyle(
                  color: AppColors.pureWhite,
                  fontSize: context.wPct(8.5),
                  fontWeight: FontWeight.w600,
                ),
              ),
              context.hBox(0.5),
              Text(
                'education_pic_subtitle'.tr,
                style: TextStyle(
                  color: AppColors.softWhite70,
                  fontSize: context.wPct(3.5),
                  fontWeight: FontWeight.w500,
                ),
              ),

              context.hBox(6),
              IdImagePicker(
                isEducation: true,
                imagePath: AppAssetPaths.nationalID,
                text: Text(
                  'education_pic_note'.tr,
                  style: TextStyle(
                    color: AppColors.softWhite70,
                    fontSize: context.wPct(4),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                onImageSelected: controller.setEducationImage,
              ),
              Obx(() {
                return Visibility(
                  visible: controller.educationImgError.value != null,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: context.wPct(2),
                      top: context.hPct(1),
                    ),
                    child: Text(
                      controller.educationImgError.value ?? "",
                      style: TextStyle(
                        color: AppColors.coralRed,
                        fontSize: context.wPct(3),
                      ),
                    ),
                  ),
                );
              }),
              context.hBox(2),
              RegisterNote(note: 'education_pic_note_1'.tr),
              context.hBox(2),
              RegisterNote(note: 'education_pic_note_2'.tr),
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
          onPressed: controller.validateAndContinue,
          child: Text('education_pic_confirm_button'.tr),
        ),
      ),
    );
  }
}
