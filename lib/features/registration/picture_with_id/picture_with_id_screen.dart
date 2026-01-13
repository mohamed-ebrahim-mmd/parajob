import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/registration/picture_with_id/picture_withl_id_controller.dart';
import 'package:para_job/features/registration/widgets/id_img_picker.dart';
import 'package:para_job/features/registration/widgets/registration_note.dart';
import 'package:para_job/features/registration/widgets/stepper.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/res/app_asset_paths.dart';

class PictureWithIdScreen extends StatelessWidget {
  final controller = Get.put(PictureWithIdController());

  PictureWithIdScreen({super.key});

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
                'picture_with_id_title'.tr,
                style: TextStyle(
                  color: AppColors.pureWhite,
                  fontSize: context.wPct(8.5),
                  fontWeight: FontWeight.w600,
                ),
              ),
              context.hBox(0.5),
              Text(
                'picture_with_id_subtitle'.tr,
                style: TextStyle(
                  color: AppColors.softWhite70,
                  fontSize: context.wPct(3.5),
                  fontWeight: FontWeight.w500,
                ),
              ),

              context.hBox(6),
              IdImagePicker(
                galleryOption: false,
                imagePath: AppAssetPaths.userWithID,
                text: Text(
                  'picture_with_id_instruction'.tr,
                  style: TextStyle(
                    color: AppColors.softWhite70,
                    fontSize: context.wPct(4),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onImageSelected: controller.sePictureWithIdImage,
              ),
              Obx(() {
                return Visibility(
                  visible: controller.picIdError.value != null,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: context.wPct(2),
                      top: context.hPct(1),
                    ),
                    child: Text(
                      controller.picIdError.value ?? "",
                      style: TextStyle(
                        color: AppColors.coralRed,
                        fontSize: context.wPct(3),
                      ),
                    ),
                  ),
                );
              }),
              context.hBox(2),
              RegisterNote(note: 'picture_with_id_note_1'.tr),
              context.hBox(2),
              RegisterNote(note: 'picture_with_id_note_2'.tr),
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
            onPressed: controller.isPictureWithIdValid
                ? controller.validateAndContinue
                : null,
            child: Text('picture_with_id_confirm_button'.tr),
          );
        }),
      ),
    );
  }
}
