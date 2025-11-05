import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/profile/edit_profile/edit_cv/edit_cv_controller.dart';
import 'package:para_job/features/profile/edit_profile/edit_cv/pdf_viewer_page.dart';
import 'package:para_job/features/profile/edit_profile/edit_cv/widgets/cv_container.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
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
            text: controller.selectedCvName.value ?? "-",
            onEdit: controller.pickFile,
            onShowPdf: () {
              Get.toNamed(
                "${Routes.mainNavigator}${Routes.more}${Routes.editProfile}${Routes.pdfViewer}",
                parameters: {'path': controller.selectedCvPath ?? "_"},
              );
            },
          ),
        ),

        Spacer(),
        FilledButton(
          onPressed: controller.uploadFile,
          child: Text("Save changes"),
        ),
        context.hBox(2.5),
      ],
    );
  }
}
