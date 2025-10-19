import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:para_job/features/registration/widgets/register_img_picker.dart';
import 'package:para_job/features/registration/widgets/registration_note.dart';
import 'package:para_job/features/registration/widgets/stepper.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/res/app_asset_paths.dart';

class EducationPicScreen extends StatelessWidget {
  const EducationPicScreen({super.key});

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
      body: 
      
      Padding(
        padding: EdgeInsets.symmetric(horizontal: context.wPct(5)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              context.hBox(2),
              StepperRow(currentStep: 3, stepPercentage: "60%"),
              //  Align(alignment: AlignmentGeometry.bottomRight, child: Text("20%")),
              context.hBox(2),
              Text(
                'Education',
                style: TextStyle(
                  color: AppColors.pureWhite,
                  fontSize: context.wPct(8.5),
                  fontWeight: FontWeight.w600,
                ),
              ),
              context.hBox(0.5),
              Text(
                'Time to verify your university',
                style: TextStyle(
                  color: AppColors.softWhite70,
                  fontSize: context.wPct(3.5),
                  fontWeight: FontWeight.w500,
                ),
              ),

              context.hBox(6),
              IDImagePicker(
                isEducation: true,
                imagePath: AppAssetPaths.nationalID,
                text: Text(
                  "Note :\nYou can scan any other document that proves \nyou’re a university student.",
                  style: TextStyle(
                    color: AppColors.softWhite70,
                    fontSize: context.wPct(4),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              context.hBox(2),
              RegisterNote(note: "Make sure your surroundings are well-lit."),
              context.hBox(2),
              RegisterNote(
                note:
                    "Make sure the photo is inside the frame and \ndetails are easy to read",
              ),
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
          onPressed: () {
             Get.toNamed(
                  "${Routes.createAccount}${Routes.createAccountOTP}${Routes.createAccountSetPass}${Routes.createAccountFrontID}${Routes.createAccountBackID}${Routes.createAccountPicWithID}${Routes.educationInfo}${Routes.educationPic}${Routes.create_account_skills}",
                );
          },
          child: Text("Confirm"),
        ),
      ),
    );
  }
}
