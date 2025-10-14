/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-12 2:46 PM
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/res/app_asset_paths.dart';

class AuthChoiceScreen extends StatelessWidget {
  const AuthChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  appBar: AppBar(title: Text('Auth Choice Screen')),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(AppAssetPaths.getStartedBackground, fit: BoxFit.cover),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.wPct(8)),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                context.hBox(25),

                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'PARA\t',

                    style: TextStyle(
                      color: AppColors.pureWhite,
                      fontSize: context.wPct(10),
                      fontWeight: FontWeight.w300,
                    ),
                    children: [
                      TextSpan(
                        text: 'JOB',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),

                context.hBox(7),
                Text(
                  "Sign in or create an account ",
                  style: TextStyle(
                    color: AppColors.pureWhite,
                    fontSize: context.wPct(5),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                context.hBox(3),

                // button to sign in with email
               
                   OutlinedButton(
                    onPressed: () {
                      Get.toNamed(
                        "${Routes.authChoice}${Routes.emailLoginScreen}",
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.email_outlined,
                          size: context.wPct(6),

                          color: AppColors.pureWhite,
                        ),
                        context.wBox(3),
                        Text('Continue with Email'),
                      ],
                    ),
                  ),
              
                context.hBox(2.5),
                //text
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'By Continuing, you agree to ParaJob\t'
                      ,
                      style: TextStyle(
                        color: AppColors.pureWhite,
                        fontSize: context.wPct(3.3),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    GestureDetector(
                      child: Text(
                        "Privacy Policy",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.aquaTeal,
                          color: AppColors.aquaTeal,
                          fontSize: context.wPct(3.3),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                context.hBox(3),
                //divider
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: AppColors.slateGray,
                        thickness: context.hPct(0.2),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.wPct(2),
                      ),
                      child: Text(
                        "Or",
                        style: TextStyle(
                          color: AppColors.pureWhite,
                          fontSize: context.wPct(4),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: AppColors.slateGray,
                        thickness: context.hPct(0.2),
                      ),
                    ),
                  ],
                ),

                context.hBox(5),

                // continue as guest
                GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        AppAssetPaths.guestUserIcon,
                        //  height: context.hPct(6),
                      ),

                      context.hBox(2.5),

                      Text(
                        "Continue as Guest User",
                        style: TextStyle(
                          color: AppColors.lightGray,
                          fontSize: context.wPct(5),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            bottom: context.hPct(4),
            left: context.wPct(8),
           // right: context.wPct(8),
            child: GestureDetector(
              onTap: () {
                // Get.toNamed(Routes.supportScreen);
              },
              child: Text(
                "Need help ?",
                style: TextStyle(
                  color: AppColors.aquaTeal,
                  fontSize: context.wPct(5),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
