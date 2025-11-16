/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 15/02/2025 5:24 PM
 ==================================================================
*/
const Map<String, String> enUS = {
  // ============================================================
  // 🏠 Onboarding Screen
  // ============================================================
  'onboarding_title': 'Welcome to Para Job!',
  'onboarding_subtitle': 'Find your next job opportunity easily and quickly.',
  'onboarding_next': 'Next',
  'onboarding_skip': 'Skip',
  'onboarding_get_started': 'Get Started',

  // ============================================================
  // 🔐 Login Screen
  // ============================================================
  'login_title': 'Welcome back',
  'login_email_hint': 'Enter your Email',
  'login_password_hint': 'Enter your Password',
  'login_button': 'Sign in',
  'login_forgot_password': 'Forgot Password?',
  'login_no_account': "don't have an account?",
  'login_sign_up': 'sign up',

  // ============================================================
  // 🔑 Forgot Password Screen
  // ============================================================
  'forgot_password_title': 'Forgot Password',
  'forgot_password_subtitle':
      'please enter your phone number to receive\n your verification OTP',
  'forgot_password_phone_hint': 'Enter your phone number',
  'forgot_password_send_button': 'Send',

  // ============================================================
  // 🔢 Forgot Password OTP Screen
  // ============================================================
  'forgot_password_otp_title': 'Verify your number',
  'forgot_password_otp_subtitle': 'check your messages to find the  OTP',
  'forgot_password_otp_verify_button': 'Verify',
  'forgot_password_otp_resend_button': 'Send again',

  // ============================================================
  // 🔐 Set New Password Screen
  // ============================================================
  'set_new_password_title': 'Set password',
  'set_new_password_hint': 'Enter your new password',
  'set_new_password_confirm_hint': 'Confirm your new Password',
  'set_new_password_confirm_button': 'Confirm',

  // ============================================================
  // 📝 Create Account Screen
  // ============================================================
  'create_account_title': 'Create a new account',
  'create_account_main_info': 'Main Information',
  'create_account_name_hint': 'Enter your Full Name',
  'create_account_dob_hint': 'Enter your Date of Birth',
  'create_account_phone_hint': 'Enter your phone Number',
  'create_account_email_hint': 'Enter your Email',
  'create_account_id_hint': 'Enter your id number',
  'create_account_gender_hint': 'Choose your gender',
  'create_account_location_info': 'Location  information',
  'create_account_loading_cities': 'Loading cities...',
  'create_account_city_hint': 'Choose your city',
  'create_account_failed_load_retry': 'Failed to load, tap to retry',
  'create_account_loading_areas': 'Loading areas...',
  'create_account_failed_load_areas': 'Failed to load areas, tap to retry',
  'create_account_select_city_first': 'Select a city first',
  'create_account_continue_button': 'Continue',
  'create_account_contact_us': 'contact us',

  // ============================================================
  // 🔢 Create Account OTP Screen
  // ============================================================
  'create_account_otp_title': 'Verify your number',
  'create_account_otp_subtitle': 'check your messages to find the  OTP',
  'create_account_otp_verify_button': 'Verify',
  'create_account_otp_resend_button': 'Send again',
  'create_account_otp_contact_us': 'contact us',

  // ============================================================
  // 🔑 Create Account Set Password Screen
  // ============================================================
  'create_account_set_pass_title': 'Set New Password',
  'create_account_set_pass_password_hint': 'Enter password',
  'create_account_set_pass_confirm_hint': 'Re-enter',
  'create_account_set_pass_continue_button': 'Continue',
  'create_account_set_pass_contact_us': 'contact us',

  // ============================================================
  // 🆔 Back National ID Screen
  // ============================================================
  'back_national_id_title': 'National ID Scan',
  'back_national_id_subtitle': 'Time to verify your identity',
  'back_national_id_scan_text_1': 'Scan the',
  'back_national_id_scan_text_back': ' back',
  'back_national_id_scan_text_2': ' of the ID',
  'back_national_id_note_1': 'Make sure your surroundings are well-lit.',
  'back_national_id_note_2':
      'Make sure the photo is inside the frame and \ndetails are easy to read',
  'back_national_id_confirm_button': 'Confirm',

  // ============================================================
  // 🆔 Front National ID Screen
  // ============================================================
  'front_national_id_title': 'National ID Scan',
  'front_national_id_subtitle': 'Time to verify your identity',
  'front_national_id_scan_text_1': 'Scan the',
  'front_national_id_scan_text_front': ' front',
  'front_national_id_scan_text_2': ' of the ID',
  'front_national_id_note_1': 'Make sure your surroundings are well-lit.',
  'front_national_id_note_2':
      'Make sure the photo is inside the frame and \ndetails are easy to read',
  'front_national_id_confirm_button': 'Confirm',

  // ============================================================
  // 📸 Picture With ID Screen
  // ============================================================
  'picture_with_id_title': 'National ID Scan',
  'picture_with_id_subtitle': 'Time to verify your identity',
  'picture_with_id_instruction': 'Take a picture of yourself holding the ID.',
  'picture_with_id_note_1':
      "Make sure you're looking up at the camera\nfacing the light.",
  'picture_with_id_note_2': 'Make sure the the details are easy to read.',
  'picture_with_id_confirm_button': 'Confirm',

  // ============================================================
  // 🎓 Education Info Screen
  // ============================================================
  'education_info_title': 'Education',
  'education_info_loading_universities': 'Loading universities...',
  'education_info_university_hint': 'Choose your university',
  'education_info_failed_load_universities':
      'Failed to load universities, tap to retry',
  'education_info_loading_faculties': 'Loading faculties...',
  'education_info_faculty_hint': 'Choose your faculty',
  'education_info_failed_load_faculties':
      'Failed to load faculties, tap to retry',
  'education_info_select_university_first': 'Select a university first',
  'education_info_graduation_year_hint': 'Choose your graduation year',
  'education_info_status_hint': 'Status',
  'education_info_continue_button': 'Continue',
  'education_info_contact_us': 'contact us',

  // ============================================================
  // 📷 Education Picture Screen
  // ============================================================
  'education_pic_title': 'Education',
  'education_pic_subtitle': 'Time to verify your university',
  'education_pic_note':
      "Note :\nYou can scan any other document that proves \nyou're a university student.",
  'education_pic_note_1': 'Make sure your surroundings are well-lit.',
  'education_pic_note_2':
      'Make sure the photo is inside the frame and \ndetails are easy to read',
  'education_pic_confirm_button': 'Confirm',

  // ============================================================
  // 💪 Create Account Skills Screen
  // ============================================================
  'create_account_skills_title': 'Add skills',
  'create_account_skills_loading': 'Loading skills...',
  'create_account_skills_hint': 'Choose skill',
  'create_account_skills_failed_load': 'Failed to load, tap to retry',
  'create_account_skills_continue_button': 'Continue',
  'create_account_skills_contact_us': 'contact us',

  // ============================================================
  // 📄 Create Account CV Screen
  // ============================================================
  'create_account_cv_title': 'Upload CV',
  'create_account_cv_subtitle': "It's time to Upload your cv.",
  'create_account_cv_confirm_button': 'Confirm',

  // ============================================================
  // 🏡 Home Screen
  // ============================================================
  'home_greeting': 'Hello',
  'home_welcome_back': 'Welcome back!',
  'home_find_jobs': 'Find Jobs',
  'home_notifications': 'Notifications',

  // ============================================================
  // ⚙️ Settings Screen
  // ============================================================
  'settings_title': 'Settings',
  'settings_language': 'Language',
  'settings_logout': 'Logout',
  'settings_dark_mode': 'Dark Mode',

  // ============================================================
  // 🏡 Home Screen
  // ============================================================
  'welcome': 'Welcome, @name',
  'guest': 'Guest',
  'discover_jobs': 'Discover jobs',
  'hot_jobs': 'Hot Jobs',
  'flexible_jobs': 'Flexible Jobs',
  'non_flexible_jobs': 'Non-Flexible Jobs',
  'search_job_hint': 'Search by job title',
  'filter': 'Filter',
  'job_type': 'Job type',
  'skills': 'Skills',
  'company': 'Company',
  'categories': 'Categories',
  'apply_filter': 'Apply Filter',
  'see_all': 'See all',
  'apply_now': 'Apply now',
  'egp': 'EGP',
  'per_month': '/mo',

  // ============================================================
  // 🏡 job details Screen
  // ============================================================
  'description': 'Description',
  'requirements': 'Requirements',
  'required_skills': 'Required Skills',
  'delete_my_application': 'Delete my application',
  'apply_for_job': 'Apply for this job',
  'delete_application_confirmation':
      'Are you sure that you want to delete your application for this job?',
  'delete_application_warning':
      'Warning: if you try to delete your application 48 hours before this you will pay a fee on your next job.',

  // ============================================================
  // 🏡 apply job Screen
  // ============================================================
  'review_application': 'Review Application',
  'full_name': 'Full Name',
  'phone': 'Phone',
  'email': 'Email',
  'status': 'Status',
  'national_id': 'National ID',
  'document': 'Document',
  'uploaded': 'Uploaded',
  'apply_job_button': 'Yes, Apply for this job',

  // ============================================================
  // complaint Screen
  // ============================================================
  'submit_complaint': 'Submit a complaint',
  'about': 'about ',
  'complaint_hint': 'Share your issues with us..',
  'submit_complaint_button': 'Submit your complaint',
  'company_already_complaint':
      'You have already filed a complaint for this company.',
  'complaint_about': 'Complaint about @name',

  // ============================================================
  // 👤 Profile Screen
  // ============================================================
  'profile_no_job_history': 'No job history found',
  'profile_job_history_title': 'Your job history',
  'profile_no_saved_jobs': 'No saved jobs found',
  'profile_saved_jobs_title': 'Saved Jobs',

  // ============================================================
  // 👤 Profile Info Widget
  // ============================================================
  'profile_info_jobs': 'JOBS',
  'profile_info_income': 'INCOME',
  'profile_info_companies': 'COMPANIES',

  // ============================================================
  // ⚡ More Screen (Settings)
  // ============================================================
  'more_settings_title': 'Settings',
  'more_language': 'Language',
  'more_account_title': 'Account',
  'more_edit_personal_info': 'Edit Personal Info',
  'more_change_password': 'Change Password',
  'more_delete_account': 'Delete Account',
  'more_delete_account_confirmation':
      'Are you sure that you want to delete your account?',
  'more_delete_account_warning':
      'Warning: if you deleted your account you will lose all your data and your level rank.',
  'more_delete_account_button': 'Delete my account',
  'more_logout': 'Log Out',
  'more_logout_confirmation':
      'Are you sure that you want to log out of your account?',
  'more_logout_button': 'Log out',
  'more_help_title': 'Help',
  'more_about_us': 'About Us',
  'more_contact_us': 'Contact Us',

  // ============================================================
  // ℹ️ About Us Screen
  // ============================================================
  'about_us_about_app': 'About the application',
  'about_us_rate_app': 'Rate us on App store',
  'about_us_instagram': 'Follow us on instagram',
  'about_us_twitter': 'Follow us on Twitter',
  'about_us_facebook': 'Like us on facebook',

  // ============================================================
  // 📚 About App Screen
  // ============================================================
  'about_app_title': 'About ParaJob',
  'about_app_vision_default': 'Our Vision',
  'about_app_mission_default': 'Our Mission',
  'about_app_values_default': 'Our values',

  // ============================================================
  // 📧 Contact Us Screen
  // ============================================================
  'contact_us_title': 'Complain or Suggest',
  'contact_us_message_hint': 'Share your issues with us..',
  'contact_us_heading': 'Contact us',
  'contact_us_email_title': 'Email us on',
  'contact_us_phone_title': 'By phone',
  'contact_us_submit_button': 'Submit your complaint',

  // ============================================================
  // ✏️ Edit Main Info Screen
  // ============================================================
  'edit_main_info_loading_cities': 'Loading cities...',
  'edit_main_info_city_hint': 'Choose your city',
  'edit_main_info_failed_load_cities': 'Failed to load, tap to retry',
  'edit_main_info_loading_areas': 'Loading areas...',
  'edit_main_info_failed_load_areas': 'Failed to load areas, tap to retry',
  'edit_main_info_select_city_first': 'Select a city first',
  'edit_main_info_save_button': 'Save changes',

  // ============================================================
  // 🎓 Edit Education Screen
  // ============================================================
  'edit_education_loading_faculties': 'Loading faculties...',
  'edit_education_faculty_hint': 'Choose your faculty',
  'edit_education_failed_load': 'Failed to load, tap to retry',
  'edit_education_save_button': 'Save changes',

  // ============================================================
  // 📄 Edit CV Screen
  // ============================================================
  'edit_cv_save_button': 'Save changes',

  // ============================================================
  // 🆔 Edit National ID Screen
  // ============================================================
  'edit_national_id_save_button': 'Save changes',

  // ============================================================
  // ✏️ Edit Profile Screen
  // ============================================================
  'edit_profile_title': 'Edit personal info',
  'edit_profile_tab_main_info': 'Main info',
  'edit_profile_tab_education': 'Education',
  'edit_profile_tab_cv': 'Cv',
  'edit_profile_tab_national_id': 'Nation ID',
  'edit_profile_tab_skills': 'Skills',

  // ============================================================
  // 🎯 Edit Skills Screen
  // ============================================================
  'edit_skills_loading': 'Loading skills...',
  'edit_skills_hint': 'Choose skill',
  'edit_skills_failed_load': 'Failed to load, tap to retry',
  'edit_skills_save_button': 'Save changes',

  // ============================================================
  // 🔍 Change Password OTP Screen
  // ============================================================
  'change_pass_otp_title': 'Verify your number',
  'change_pass_otp_subtitle': 'check your messages to find the  OTP',
  'change_pass_otp_verify_button': 'Verify',
  'change_pass_otp_resend_button': 'Send again',

  // ============================================================
  // 🔐 Change Password Screen
  // ============================================================
  'change_password_title': 'Set password',
  'change_password_new_hint': 'Enter your new password',
  'change_password_confirm_hint': 'Confirm your new Password',
  'change_password_confirm_button': 'Confirm',

  // ============================================================
  // 🔔 My Notifications Screen
  // ============================================================
  'notifications_no_found': 'No notifications found',
};
