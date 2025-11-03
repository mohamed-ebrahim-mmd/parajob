import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:para_job/features/profile/edit_profile/edit_national_id/widgets/custom_image.dart';
import 'package:para_job/features/profile/user_profile/profile_controller.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class EditNationalIdScreen extends StatelessWidget {
  EditNationalIdScreen({super.key});
  final oldUser = Get.find<ProfileController>().profileData;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          context.hBox(5),

          CustomEditImage(img: oldUser?.nationalIdFront ?? ""),
          context.hBox(5),

          CustomEditImage(img: oldUser?.nationalIdBack ?? ""),
          context.hBox(5),

          CustomEditImage(img: oldUser?.profilePicture ?? ""),
          context.hBox(5),
        ],
      ),
    );
  }
}
