/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-14 11:05 AM
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class EmailLoginScreen extends StatelessWidget {
  const EmailLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.wPct(8)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              context.hBox(15),
              Text(
                'Welcome back',
                style: TextStyle(
                  color: AppColors.pureWhite,
                  fontSize: context.wPct(8.5),
                  fontWeight: FontWeight.w600,
                ),
              ),
              context.hBox(6),
              TextField(
                decoration: InputDecoration(hintText: "Enter your Email"),
              ),
              context.hBox(1.5),
              TextField(
                decoration: InputDecoration(hintText: "Enter your Password"),
              ),
              context.hBox(1.5),
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () { Get.toNamed(
                      "${Routes.forgotPassword}",
                    );},
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: AppColors.pureWhite,
                      fontSize: context.wPct(4.2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
     
     
     
     
     
     
     
     
     
      bottomSheet: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.wPct(8),
          vertical: context.hPct(7),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FilledButton(onPressed: () {}, child: Text("Sign in")),
            context.hBox(4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "don't have an account?",
                  style: TextStyle(
                    color: AppColors.pureWhite,
                    fontSize: context.wPct(4.2),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                context.wBox(2),
                GestureDetector(
                  child: Text(
                    "sign up",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: AppColors.pureWhite,
                      fontSize: context.wPct(4.2),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
   
   
   
    );
  }
}
