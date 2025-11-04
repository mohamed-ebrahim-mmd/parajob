import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:para_job/features/profile/edit_profile/edit_national_id/edit_national_id_controller.dart';
import 'package:para_job/features/profile/edit_profile/edit_national_id/widgets/custom_image.dart';
import 'package:para_job/features/profile/user_profile/profile_controller.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class EditNationalIdScreen extends StatelessWidget {
  EditNationalIdScreen({super.key, required this.screenContext});
 final BuildContext screenContext;
  final user = Get.find<ProfileController>().profileData;
    late final controller = Get.put(
    EditNationalIdController(screenContext:  screenContext),
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
      
            CustomEditImage(img: user?.nationalIdFront ?? "",onEdit: controller.pickImg,),
            context.hBox(5),
      
            CustomEditImage(img: user?.nationalIdBack ?? "",onEdit: controller.pickImg,),
            context.hBox(5),
      
            CustomEditImage(img: user?.profilePicture ?? "",onEdit: controller.pickImg,),
            context.hBox(5),
             Spacer(),
              // FilledButton(
              //   onPressed: controller.editUser,
              //   child: Text("Save changes"),
              // ),
              context.hBox(2.5),

          ],
        ),
      ),
      ])
    );
  }
}
