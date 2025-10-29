
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:para_job/features/profile/user_profile/profile_controller.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

class EditMainInfo extends StatelessWidget {
   EditMainInfo({super.key, });
 var user=  Get.find<ProfileController>().profileData;

  @override
  Widget build(BuildContext context,) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.wPct(5)),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              context.hBox(4),
              TextField(
                enabled: false,
                decoration: InputDecoration(
                  label: Text(user?.name??""),
                  fillColor: AppColors.disabled,
                  filled: true,
                ),
              ),

              context.hBox(1.5),

              // Email Address TF
              TextField(
                // controller: controller.emailController,
                decoration: InputDecoration(hintText: "Enter your Email"),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              context.hBox(1.5),
              TextField(
                enabled: false,
                decoration: InputDecoration(
                  label: Text(user?.phoneNumber??""),
                  fillColor: AppColors.disabled,
                  filled: true,
                ),
              ),
              context.hBox(1.5),
              TextField(
                enabled: false,
                decoration: InputDecoration(
                  label: Text(user?.dateOfBirth??""),
                  fillColor: AppColors.disabled,
                  filled: true,
                ),
              ),
              context.hBox(1.5),
              TextField(
                enabled: false,
                decoration: InputDecoration(
                  // hintText: "Enter your phone Number",
                  label: Text(user?.gender??""),
                  fillColor: AppColors.disabled,
                  filled: true,
                ),
              ),
              context.hBox(1.5),
              DropdownMenu<String>(
                enableSearch: true,
                expandedInsets: EdgeInsets.zero,
               // hintText: "Choose your gender",
                // initialSelection: controller.selectedGender,
                // onSelected: controller.onGenderSelected,
                dropdownMenuEntries: [],
              ),
              context.hBox(1.5),
              DropdownMenu<String>(
                enableSearch: true,
                expandedInsets: EdgeInsets.zero,
                hintText: "Choose your gender",
                // initialSelection: controller.selectedGender,
                // onSelected: controller.onGenderSelected,
                dropdownMenuEntries: [],
              ),
              context.hBox(2.5),
            ],
          ),
        ),
      ),
    );
  }
}
