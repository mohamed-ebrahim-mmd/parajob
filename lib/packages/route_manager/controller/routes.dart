/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 23/02/2025 8:17 AM
 ==================================================================
*/

import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/features/authentication/authentication_choice/auth_choice_screen.dart';
import 'package:para_job/features/authentication/email_login/email_login_screen.dart';
import 'package:para_job/features/authentication/forgot_password/forgot_password_screen.dart';
import 'package:para_job/features/authentication/forgot_password_otp/forgot_password_otp_screen.dart';
import 'package:para_job/features/authentication/set_new_password/set_new_password_screen.dart';
import 'package:para_job/features/company_details/company_details_screen.dart';
import 'package:para_job/features/home/jobs/jobs_screen.dart';
import 'package:para_job/features/home/search_job/search_job_screen.dart';
import 'package:para_job/features/job_details/job_details_screen.dart';
import 'package:para_job/features/main_navigator/main_navigator_screen.dart';
import 'package:para_job/features/onboarding/onboarding_screen.dart';
import 'package:para_job/features/profile/about_app/about_app_screen.dart';
import 'package:para_job/features/profile/about_us/about_us_screen.dart';
import 'package:para_job/features/profile/contact_us/contact_us_screen.dart';
import 'package:para_job/features/profile/edit_profile/edit_profile_screen.dart';
import 'package:para_job/features/profile/more/more_screen.dart';
import 'package:para_job/features/registration/back_national_id/back_national_id_screen.dart';
import 'package:para_job/features/registration/create_account/create_account_screen.dart';
import 'package:para_job/features/registration/create_account_cv/create_account_cv_screen.dart';
import 'package:para_job/features/registration/create_account_otp/create_account_otp_screen.dart';
import 'package:para_job/features/registration/create_account_set_pass/create_account_set_pass.dart';
import 'package:para_job/features/registration/create_account_skills/create_account_skills_screen.dart';
import 'package:para_job/features/registration/education_info/education_info_screen.dart';
import 'package:para_job/features/registration/education_pic/education_pic_screen.dart';
import 'package:para_job/features/registration/front_national_id/front_national_id_screen.dart';
import 'package:para_job/features/registration/picture_with_id/picture_with_id_screen.dart';
import 'package:para_job/packages/ui_components/app_loader.dart';

class Routes {
  static const String onboarding = '/onboarding';
  static const String forgotPasswordOTP = '/forgot-password-otp';
  static const String setNewPassword = '/set-new-password';
  static const String authChoice = '/auth-choice';
  static const String mainNavigator = '/main-navigator';
  static const String emailLoginScreen = '/email-login';
  static const String forgotPassword = '/forgot-password';
  static const String createAccount = '/create-account';
  static const String info = '/info';
  static const String createAccountOTP = '/create-account-otp';
  static const String createAccountSetPass = '/create-account-set-pass';
  static const String createAccountFrontID = '/create-account-front-id';
  static const String createAccountBackID = '/create-account-back-id';
  static const String createAccountPicWithID = '/create-account-pic-with-id';
  static const String educationInfo = '/education-info';
  static const String educationPic = '/education-pic';
  static const String searchJob = '/search-job';
  static const String createAccountSkills = '/create-account-skills';
  static const String createAccountCv = '/create-account-cv';
  static const String jobs = '/jobs';
  static const String jobDetails = '/job-details';
  static const String companyDetails = '/company-details';
  static const String more = "/more-screen";
  static const String aboutUs = "/about-us";
  static const String aboutApp = "/about-app";
  static const String contactUs = "/contacts-us";
  static const String editProfile = "/edit-profile";
}

class AppPages {
  static final pages = [
    GetPage(name: Routes.onboarding, page: () => OnboardingScreen()),
    GetPage(
      name: Routes.authChoice,
      page: () => AuthChoiceScreen(),
      children: [
        GetPage(
          name: Routes.emailLoginScreen,
          page: () => LoaderOverlay(
            child: EmailLoginScreen(),
            overlayWidgetBuilder: (_) {
              //ignored progress for the moment
              return AppLoader();
            },
          ),
          children: [
            GetPage(
              name: Routes.forgotPassword,
              page: () => LoaderOverlay(
                child: ForgotPasswordScreen(),
                overlayWidgetBuilder: (_) {
                  //ignored progress for the moment
                  return AppLoader();
                },
              ),
              children: [
                GetPage(
                  name: Routes.forgotPasswordOTP,
                  page: () => LoaderOverlay(
                    child: ForgotPasswordOtpScreen(),
                    overlayWidgetBuilder: (_) {
                      //ignored progress for the moment
                      return AppLoader();
                    },
                  ),
                  children: [
                    GetPage(
                      name: Routes.setNewPassword,
                      page: () => LoaderOverlay(
                        child: SetNewPasswordScreen(),
                        overlayWidgetBuilder: (_) {
                          //ignored progress for the moment
                          return AppLoader();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),

    GetPage(
      name: Routes.createAccount,
      page: () => CreateAccountScreen(),
      children: [
        GetPage(
          name: Routes.createAccountOTP,
          page: () => LoaderOverlay(
            child: CreateAccountOtpScreen(),
            overlayWidgetBuilder: (_) {
              //ignored progress for the moment
              return AppLoader();
            },
          ),
          children: [
            GetPage(
              name: Routes.createAccountSetPass,
              page: () => LoaderOverlay(
                child: CreateAccountSetPass(),
                overlayWidgetBuilder: (_) {
                  //ignored progress for the moment
                  return AppLoader();
                },
              ),
              children: [
                GetPage(
                  name: Routes.createAccountFrontID,
                  page: () => FrontNationalIdScreen(),
                  children: [
                    GetPage(
                      name: Routes.createAccountBackID,
                      page: () => BackNationalIdScreen(),
                      children: [
                        GetPage(
                          name: Routes.createAccountPicWithID,
                          page: () => PictureWithIdScreen(),
                          children: [
                            GetPage(
                              name: Routes.educationInfo,
                              page: () => EducationInfoScreen(),
                              children: [
                                GetPage(
                                  name: Routes.educationPic,
                                  page: () => EducationPicScreen(),
                                  children: [
                                    GetPage(
                                      name: Routes.createAccountSkills,
                                      page: () => CreateAccountSkillsScreen(),
                                      children: [
                                        GetPage(
                                          name: Routes.createAccountCv,
                                          page: () => CreateAccountCvScreen(),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),

    //CompanyDetailsScreen
    GetPage(name: Routes.createAccount, page: () => CreateAccountScreen()),
    GetPage(
      name: Routes.jobDetails,
      page: () => JobDetailsScreen(),
      children: [
        GetPage(
          name: Routes.companyDetails,
          page: () => CompanyDetailsScreen(),
        ),
      ],
    ),
    GetPage(
      name: Routes.mainNavigator,
      page: () => LoaderOverlay(
        child: MainNavigatorScreen(),
        overlayWidgetBuilder: (_) {
          //ignored progress for the moment
          return AppLoader();
        },
      ),

      children: [
        /// screens that's under the home tab
        GetPage(name: Routes.jobs, page: () => JobsScreen()),
        GetPage(name: Routes.searchJob, page: () => SearchJobScreen()),

        //profile
        GetPage(
          name: Routes.more,
          page: () => LoaderOverlay(
            child: MoreScreen(),
            overlayWidgetBuilder: (_) {
              //ignored progress for the moment
              return AppLoader();
            },
          ),

          children: [
            GetPage(
              name: Routes.contactUs,
              page: () => LoaderOverlay(
                child: ContactUsScreen(),
                overlayWidgetBuilder: (_) {
                  //ignored progress for the moment
                  return AppLoader();
                },
              ),
            ),
            GetPage(
              name: Routes.aboutUs,
              page: () => AboutUsScreen(),
              children: [
                GetPage(name: Routes.aboutApp, page: () => AboutAppScreen()),
              ],
            ),

            GetPage(name: Routes.editProfile, page: () => LoaderOverlay(
            child: EditProfileScreen(),
            overlayWidgetBuilder: (_) {
              //ignored progress for the moment
              return AppLoader();
            },
          ),

            ),
          ],
        ),
      ],
    ),
  ];
}
