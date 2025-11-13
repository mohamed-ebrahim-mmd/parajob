import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/profile/edit_profile/edit_cv/edit_cv_controller.dart';
import 'package:para_job/features/profile/edit_profile/edit_cv/widgets/cv_container.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class EditCvScreen extends StatelessWidget {
  EditCvScreen({super.key, required this.screenContext});
  final BuildContext screenContext;
  late final controller = Get.put(
    EditCvController(screenContext: screenContext),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        context.hBox(5),
        Obx(
          () => EditCvContainer(
            text: controller.selectedCvName.value ?? 'edit_cv_default_name'.tr,
            onEdit: controller.pickFile,
            onShowPdf: controller.onShowPdf,
          ),
        ),

        Spacer(),
        FilledButton(
          onPressed: controller.uploadFile,
          child: Text('edit_cv_save_button'.tr),
        ),
        context.hBox(2.5),
      ],
    );
  }
}
