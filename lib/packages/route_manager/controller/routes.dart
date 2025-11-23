import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/features/authentication/authentication_choice/auth_choice_screen.dart';
import 'package:para_job/features/authentication/email_login/email_login_screen.dart';
import 'package:para_job/features/authentication/forgot_password/forgot_password_screen.dart';
import 'package:para_job/features/authentication/forgot_password_otp/forgot_password_otp_screen.dart';
import 'package:para_job/features/authentication/set_new_password/set_new_password_screen.dart';
import 'package:para_job/features/employer/active_jobs.dart/active_jobs_screen.dart';
import 'package:para_job/features/employer/employer_screen.dart';
import 'package:para_job/features/employer/reviews/employer_reviews_screen.dart';
import 'package:para_job/features/home/jobs/jobs_screen.dart';
import 'package:para_job/features/home/search_job/search_job_screen.dart';
import 'package:para_job/features/job_details/apply_job/apply_job_screen.dart';
import 'package:para_job/features/job_details/complaint/company_complaint/company_complaint_screen.dart';
import 'package:para_job/features/job_details/complaint/job_complaint/job_complaint_screen.dart';
import 'package:para_job/features/job_details/job_details_screen.dart';
import 'package:para_job/features/main_navigator/main_navigator_screen.dart';
import 'package:para_job/features/my_jobs/application_verification_otp/application_verification_otp_screen.dart';
import 'package:para_job/features/my_jobs/contract/contract_screen.dart';
import 'package:para_job/features/my_notifications/strike/notification_strike_screen.dart';
import 'package:para_job/features/onboarding/onboarding_screen.dart';
import 'package:para_job/features/profile/about_app/about_app_screen.dart';
import 'package:para_job/features/profile/about_us/about_us_screen.dart';
import 'package:para_job/features/profile/bookmarked_jobs.dart/book_marked_jobs_screen.dart';
import 'package:para_job/features/profile/change_pass/change_pass_otp/change_pass_otp_screen.dart';
import 'package:para_job/features/profile/change_pass/change_password/change_password_screen.dart';
import 'package:para_job/features/profile/contact_us/contact_us_screen.dart';
import 'package:para_job/features/profile/edit_profile/edit_cv/pdf_view/pdf_view_screen.dart';
import 'package:para_job/features/profile/edit_profile/edit_profile_screen.dart';
import 'package:para_job/features/profile/history_jobs/history_jobs_screen.dart';
import 'package:para_job/features/profile/language/language_screen.dart';
import 'package:para_job/features/profile/more/more_screen.dart';
import 'package:para_job/features/registration/back_national_id/back_national_id_screen.dart';
import 'package:para_job/features/registration/contact_us_auth/contact_us_auth_screen.dart';
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
  static const String hotJobs = '/hot_job';
  static const String flexibleJobs = '/flex_job';
  static const String nonFlexibleJobs = '/non_flex_job';
  static const String employer = '/employer';
  static const String employerReviews = '/employer-reviews';
  static const String jobDetails = '/job_details';
  static const String jobs = '/jobs';
  static const String companyDetails = '/company-details';
  static const String contract = '/contract';
  static const String applicationVerificationOTP =
      '/application-verification-otp';
  static const String more = "/more-screen";
  static const String aboutUs = "/about-us";
  static const String aboutApp = "/about-app";
  static const String contactUs = "/contacts-us";
  static const String editProfile = "/edit-profile";
  static const String applyJob = "/apply-job";
  static const String companyComplaint = "/company-complaint";
  static const String jobComplaint = "/job-complaint";
  static const String pdfViewer = "/pdf-viewer";
  static const String bookmarkedJobs = '/bookmarked_jobs';
  static const String activeJobs = '/active_jobs';
  static const String changePassOtp = '/change_pass_otp';
  static const String changePassword = '/change_password';

  static const String historyJobs = '/history_jobs';

  static const String languageScreen = "/language_screen";
  static const String notificationStrikeScreen = "/notification_strike_screen";
  static const String contactUsAuth = "/contacts-us-auth";
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

    GetPage(name: Routes.contactUsAuth, page: () => ContactUsAurhScreen()),

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
                                          page: () => LoaderOverlay(
                                            child: CreateAccountCvScreen(),
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
    GetPage(
      name: Routes.jobDetails,
      page: () => LoaderOverlay(
        child: JobDetailsScreen(),
        overlayWidgetBuilder: (_) {
          return AppLoader();
        },
      ),

      children: [
        GetPage(
          name: Routes.jobComplaint,
          page: () => LoaderOverlay(
            child: JobComplaintScreen(),
            overlayWidgetBuilder: (_) {
              return AppLoader();
            },
          ),
        ),

        GetPage(
          name: Routes.applyJob,
          page: () => LoaderOverlay(
            child: ApplyJobScreen(),
            overlayWidgetBuilder: (_) {
              return AppLoader();
            },
          ),
        ),

        GetPage(
          name: Routes.employer,
          page: () => LoaderOverlay(
            overlayWidgetBuilder: (_) => AppLoader(),
            child: EmployerScreen(),
          ),
          children: [
            GetPage(
              name: Routes.companyComplaint,
              page: () => LoaderOverlay(
                child: CompanyComplaintScreen(),
                overlayWidgetBuilder: (_) {
                  return AppLoader();
                },
              ),
            ),
            GetPage(
              name: Routes.employerReviews,
              page: () => EmployerReviewsScreen(),
            ),
            GetPage(name: Routes.activeJobs, page: () => ActiveJobsScreen()),
          ],
        ),
      ],
    ),

    /// mainNavigator screen and its child
    GetPage(
      name: Routes.mainNavigator,
      page: () => LoaderOverlay(
        child: MainNavigatorScreen(),
        overlayWidgetBuilder: (_) {
          //ignored progress for the moment
          return AppLoader();
        },
      ),

      /// screens that's under the home tab
      children: [
        // home
        GetPage(
          name: Routes.jobs,
          page: () => LoaderOverlay(
            child: JobsScreen(),
            overlayWidgetBuilder: (_) => AppLoader(),
          ),
        ),
        GetPage(
          name: Routes.searchJob,
          page: () => LoaderOverlay(
            child: SearchJobScreen(),
            overlayWidgetBuilder: (_) => AppLoader(),
          ),
        ),

        // my jobs
        GetPage(
          name: Routes.applicationVerificationOTP,
          page: () => LoaderOverlay(
            overlayWidgetBuilder: (_) => AppLoader(),
            child: ApplicationVerificationOtpScreen(),
          ),
          children: [
            GetPage(
              name: Routes.contract,
              page: () => LoaderOverlay(
                overlayWidgetBuilder: (_) => AppLoader(),
                child: ContractScreen(),
              ),
            ),
          ],
        ),
        // notification strike screen
        GetPage(
          name: Routes.notificationStrikeScreen,
          page: () => NotificationStrikeScreen(),
        ),

        //profile
        GetPage(
          name: Routes.bookmarkedJobs,
          page: () => LoaderOverlay(
            child: BookMarkedJobsScreen(),
            overlayWidgetBuilder: (_) {
              //ignored progress for the moment
              return AppLoader();
            },
          ),
        ),
        GetPage(name: Routes.historyJobs, page: () => HistoryJobsScreen()),

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
            GetPage(name: Routes.languageScreen, page: () => LanguageScreen()),
            GetPage(
              name: Routes.changePassOtp,
              page: () => LoaderOverlay(
                child: ChangePassOtpScreen(),
                overlayWidgetBuilder: (_) {
                  //ignored progress for the moment
                  return AppLoader();
                },
              ),
              children: [
                GetPage(
                  name: Routes.changePassword,
                  page: () => LoaderOverlay(
                    child: ChangePasswordScreen(),
                    overlayWidgetBuilder: (_) {
                      //ignored progress for the moment
                      return AppLoader();
                    },
                  ),
                ),
              ],
            ),
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

            GetPage(
              name: Routes.editProfile,
              page: () => LoaderOverlay(
                child: EditProfileScreen(),
                overlayWidgetBuilder: (_) {
                  //ignored progress for the moment
                  return AppLoader();
                },
              ),
              children: [
                GetPage(
                  name: Routes.pdfViewer,
                  page: () {
                    return PdfViewScreen();
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ];
}
