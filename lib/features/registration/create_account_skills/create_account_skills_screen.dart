import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:para_job/features/registration/widgets/stepper.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

import '../../../packages/route_manager/controller/routes.dart';
import '../../../packages/themeing/app_colors.dart';

class CreateAccountSkillsScreen extends StatelessWidget {
  const CreateAccountSkillsScreen({super.key});

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
                'Add skills',
                style: TextStyle(
                  color: AppColors.pureWhite,
                  fontSize: context.wPct(8.5),
                  fontWeight: FontWeight.w600,
                ),
              ),
              context.hBox(6),
              TextField(
                decoration: InputDecoration(hintText: "Enter your skills"),
                keyboardType: TextInputType.text,
                obscureText: true,
                textInputAction: TextInputAction.done,
              ),
              context.hBox(3),


       Row(
  children: [
    Flexible(
      child: Wrap(
        spacing: context.wPct(3),
        runSpacing: context.wPct(3),
        children: skills.map((skill) => SkillItem(skill: skill)).toList(),
      ),
    ),
  ],
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
                  "${Routes.createAccount}${Routes.createAccountOTP}${Routes.createAccountSetPass}${Routes.createAccountFrontID}${Routes.createAccountBackID}${Routes.createAccountPicWithID}${Routes.educationInfo}${Routes.educationPic}${Routes.create_account_skills}${Routes.create_account_cv}"
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
List<String> skills = [
  "Plumbing",
  "Electrical Work",
  "Carpentry",
  "Painting",


];


class SkillItem
 extends StatelessWidget {
  const SkillItem
  ({super.key, required this.skill});
  final String skill;

  @override
  Widget build(BuildContext context) {
    return Container( 
      height: context.hPct(5),      
      // width: context.wPct(3),

      padding: EdgeInsets.symmetric(
        horizontal: context.wPct(1),
      //  vertical: context.hPct(1.5),
      ),
      decoration: BoxDecoration(
        color: AppColors.aquaTeal8,
        border: Border.all(color: AppColors.aquaTeal),
        borderRadius: BorderRadius.circular(context.wPct(3),)
      ),
      child: Row( mainAxisSize: MainAxisSize.min,mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            skill,
            style: TextStyle(
              color: AppColors.aquaTeal,
              fontSize: context.wPct(3.4),
              fontWeight: FontWeight.w400,
            ),
          ),
          IconButton(onPressed: (){}, icon: Icon(Icons.close,color: AppColors.aquaTeal,size: context.wPct(4),))
        ],
      ),
    );
  }
}