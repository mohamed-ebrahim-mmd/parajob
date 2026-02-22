/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-12 2:46 PM
 ==================================================================
*/
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:para_job/features/authentication/authentication_choice/auth_choice_util.dart';
import 'package:para_job/features/authentication/authentication_choice/widgets/language_switcher.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/route_manager/controller/routing_controller.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/res/app_asset_paths.dart';

class AuthChoiceScreen extends StatelessWidget {
  const AuthChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  appBar: AppBar(title: Text('Auth Choice Screen')),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssetPaths.getStartedBackground),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: context.defaultPadding),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                context.hBox(1.5),
                LanguageSwitcher(),
                context.hBox(25),

                Directionality(
                  textDirection: TextDirection.ltr,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'PARA',
                      style: TextStyle(
                        color: AppColors.pureWhite,
                        fontSize: context.wPct(10),
                        fontWeight: FontWeight.w300,
                      ),
                      children: [
                        TextSpan(
                          text: 'JOB',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                context.hBox(7),
                Text(
                  'auth_choice_title'.tr,
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
                        size: context.wPct(5),

                        color: AppColors.pureWhite,
                      ),
                      context.wBox(3),
                      Text(
                        'auth_choice_continue_with_email'.tr,
                        style: TextStyle(
                          color: AppColors.pureWhite,
                          fontSize: context.wPct(4),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                if (Platform.isIOS) ...[
                  context.hBox(2.5),
                  //  button to sign in with apple store
                  OutlinedButton(
                    onPressed: () {
                      signInAndLogUserDataApple(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //svg
                        Icon(
                          Icons.apple_outlined,
                          size: context.wPct(6),
                          color: AppColors.pureWhite,
                        ),
                        context.wBox(3),
                        Text(
                          'auth_choice_continue_with_apple'.tr,
                          style: TextStyle(
                            color: AppColors.pureWhite,
                            fontSize: context.wPct(4),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                context.hBox(2.5),
                // button to sign in with gmail
                OutlinedButton(
                  onPressed: () {
                    signInAndLogUserDataGoogle(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //svg
                      SvgPicture.asset(
                        AppAssetPaths.googleIcon,
                        height: context.hPct(2.2),
                        width: context.wPct(2),
                      ),
                      context.wBox(3),
                      Text(
                        'auth_choice_continue_with_google'.tr,
                        style: TextStyle(
                          color: AppColors.pureWhite,
                          fontSize: context.wPct(4),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                context.hBox(2.5),
                //text
                Wrap(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'auth_choice_agree_to'.tr,

                      style: TextStyle(
                        color: AppColors.pureWhite,
                        fontSize: context.wPct(3.3),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          "${Routes.authChoice}${Routes.privacyPolicy}",
                        );
                      },
                      child: Text(
                        'auth_choice_privacy_policy'.tr,
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
                        'auth_choice_or'.tr,
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
                  onTap: () {
                    Get.find<RoutingController>().goHomeAsGuest();
                  },
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        AppAssetPaths.guestUserIcon,
                        //  height: context.hPct(6),
                      ),

                      context.hBox(2.5),

                      Text(
                        'auth_choice_continue_as_guest'.tr,
                        style: TextStyle(
                          color: AppColors.lightGray,
                          fontSize: context.wPct(5),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                context.hBox(4),
                Align(
                  alignment: AlignmentGeometry.bottomLeft,
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.contactUsAuth);
                    },

                    child: Text(
                      'auth_choice_need_help'.tr,
                      style: TextStyle(
                        color: AppColors.aquaTeal,
                        fontSize: context.wPct(5),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),

                context.hBox(3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
