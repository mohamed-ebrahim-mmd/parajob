import 'package:flutter/material.dart';
import 'package:para_job/features/registration/widgets/file_picker.dart';
import 'package:para_job/features/registration/widgets/stepper.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class CreateAccountCvScreen extends StatelessWidget {
  const CreateAccountCvScreen({super.key});

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
        padding: EdgeInsets.symmetric(horizontal: context.wPct(5)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              context.hBox(2),
              StepperRow(currentStep: 4, stepPercentage: "80%"),
              context.hBox(2),
              Text(
                'Upload CV',
                style: TextStyle(
                  color: AppColors.pureWhite,
                  fontSize: context.wPct(8.5),
                  fontWeight: FontWeight.w600,
                ),
              ),
              context.hBox(0.5),
              Text(
                'It’s time to Upload your cv.',
                style: TextStyle(
                  color: AppColors.softWhite70,
                  fontSize: context.wPct(3.5),
                  fontWeight: FontWeight.w500,
                ),
              ),

              context.hBox(6),
              CVUploader(),
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
            //  Get.toNamed(
            //       "${Routes.createAccount}${Routes.createAccountOTP}${Routes.createAccountSetPass}${Routes.createAccountFrontID}${Routes.createAccountBackID}${Routes.createAccountPicWithID}${Routes.educationInfo}${Routes.educationPic}${Routes.create_account_skills}",
            //     );
          },
          child: Text("Confirm"),
        ),
      ),
    );
  }
}
