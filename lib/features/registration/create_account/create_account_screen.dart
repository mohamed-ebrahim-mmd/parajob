/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-12 2:48 PM
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_component/date_packer.dart';
import 'package:para_job/packages/ui_component/drop_down_button.dart';
import 'package:para_job/packages/ui_component/stepper/stepper.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

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
              StepperRow(currentStep: -1),
              Align(
                alignment: AlignmentGeometry.bottomRight,
                child: Text("0%"),
              ),

              context.hBox(4),
              Text(
                'Create a new account',
                style: TextStyle(
                  color: AppColors.pureWhite,
                  fontSize: context.wPct(8.5),
                  fontWeight: FontWeight.w600,
                ),
              ),
              context.hBox(6),
              Text(
                'Main Information',

                style: TextStyle(
                  color: AppColors.pureWhite,
                  fontSize: context.wPct(5),
                  fontWeight: FontWeight.w500,
                ),
              ),
              context.hBox(2.5),
              // Input fields
              //Full Name TF
              TextField(
                decoration: InputDecoration(hintText: "Enter your Full Name"),
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
              ),
              context.hBox(1.5),
              // Date of Birth TF
              DatePickerField(hintText: "Enter your Date of Birth"),
              context.hBox(1.5),

              TextField(
                decoration: InputDecoration(
                  hintText: "Enter your phone Number",
                ),
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
              ),
              context.hBox(1.5),
              // Email Address TF
              TextField(
                decoration: InputDecoration(hintText: "Enter your Email"),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              context.hBox(1.5),

              TextField(
                decoration: InputDecoration(hintText: "Enter your id number"),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
              ),
              context.hBox(1.5),
              DropDownButton(
                options: ["male","female"],
                label: "Choose your gender",
              ),
              context.hBox(2.5),
              Text(
                'Location Information',

                style: TextStyle(
                  color: AppColors.pureWhite,
                  fontSize: context.wPct(5),
                  fontWeight: FontWeight.w500,
                ),
              ),
              context.hBox(2.5),
              DropDownButton(
                options: ["male","female"],
                label: "Choose your city",
              ),
              context.hBox(1.5),
              DropDownButton(
                options: ["male","female"],
                label: "Choose your area",
              ),
              context.hBox(2.5),

              FilledButton(onPressed: () {
                Get.toNamed( "${Routes.createAccount}${Routes.createAccountOTP}");
              }, child: Text("Continue")),
              context.hBox(5),
              GestureDetector(
                child: Text(
                  "contact us",
                  style: TextStyle(
                    color: AppColors.aquaTeal,
                    fontSize: context.wPct(4.2),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
                            context.hBox(2),

            ],
          ),
        ),
      ),

    );
  }
}
