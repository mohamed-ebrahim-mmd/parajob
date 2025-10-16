/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-15 10:44 AM
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class SetNewPasswordScreen extends StatelessWidget {
  const SetNewPasswordScreen({Key? key}) : super(key: key);

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
                decoration: InputDecoration(
                  hintText: "Enter your new password",
                ),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                textInputAction: TextInputAction.next,
              ),
              context.hBox(1.5),
              TextField(
                decoration: InputDecoration(
                  hintText: "Confirm your new Password",
                ),
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
          vertical: context.hPct(12),
        ),
        child: FilledButton(
          onPressed: () {
            // Get.toNamed("${Routes.forgotPassword}${Routes.forgotPasswordOTP}");
          },
          child: Text("Confirm"),
        ),
      ),
   
   
    );
  }
}
