import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/registration/widgets/stepper.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class CreateAccountSetPass extends StatelessWidget {
  const CreateAccountSetPass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              StepperRow(currentStep: 1, stepPercentage: "20%"),

              context.hBox(2),
              Text(
                'Set New Password',
                style: TextStyle(
                  color: AppColors.pureWhite,
                  fontSize: context.wPct(8.5),
                  fontWeight: FontWeight.w600,
                ),
              ),
              context.hBox(6),
              TextField(
                decoration: InputDecoration(hintText: "Enter password"),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                textInputAction: TextInputAction.next,
              ),
              context.hBox(1.5),
              TextField(
                decoration: InputDecoration(hintText: "Re-enter"),
                obscureText: true,
                textInputAction: TextInputAction.done,
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.wPct(5),
          vertical: context.hPct(2.8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            FilledButton(
              onPressed: () {
                Get.toNamed(
                  "${Routes.createAccount}${Routes.createAccountOTP}${Routes.createAccountSetPass}${Routes.createAccountFrontID}",
                );
              },
              child: Text("Continue"),
            ),

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
          ],
        ),
      ),
   
   
    );
  }
}
