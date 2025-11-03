
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:para_job/features/profile/edit_profile/edit_education/edit_education_cintroller.dart';
import 'package:para_job/features/profile/user_profile/profile_controller.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/date_packer.dart';

class EditEducation extends StatelessWidget {
     EditEducation({
    super.key, required this.screenContext,
  });
  var olderUser = Get.find<ProfileController>().profileData;
 final  BuildContext screenContext;
  

  @override
  Widget build(BuildContext context) {
     final controller = Get.put(EditEducationController( screenContext));

    return Column(
      
            children: [
                context.hBox(2.5),
              YearPickerField(selectedYear: int.tryParse( olderUser?.graduationYear??""),controller:controller.graduationYearController ,),
              context.hBox(2.5),
              TextField(
                decoration: InputDecoration(hintText: "Enter your Faculty"),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                controller: controller.facultyController,
              ),
            ],
    );
  }
}
