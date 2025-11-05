import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/profile/edit_profile/edit_national_id/edit_national_id_controller.dart';
import 'package:para_job/features/profile/edit_profile/edit_national_id/widgets/national_id_image.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class EditNationalIdScreen extends StatelessWidget {
  EditNationalIdScreen({super.key, required this.screenContext});
  final BuildContext screenContext;
  late final controller = Get.put(
    EditNationalIdController(screenContext: screenContext),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                context.hBox(5),
                Obx(
                  () => NationalIdImg(
                    img: controller.user?.nationalIdFront ?? "",
                    localFile: controller.frontFile.value,
                    onEdit: () => controller.pickImg(controller.frontFile),
                  ),
                ),

               
                context.hBox(5),

                 Obx(
                  () =>NationalIdImg(
                  img: controller.user?.nationalIdBack ?? "",
                  localFile: controller.backFile.value,
                  onEdit: () => controller.pickImg(controller.backFile),
                ),),
                context.hBox(5),

                 Obx(
                  () =>NationalIdImg(
                  img: controller.user?.profileWithId ?? "",
                  localFile: controller.profileFile.value,
                  onEdit: () => controller.pickImg(controller.profileFile),
                ),),
                context.hBox(5),
                Spacer(),
                FilledButton(
                  onPressed: controller.uploadFile,
                  child: Text("Save changes"),
                ),
                context.hBox(2.5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
