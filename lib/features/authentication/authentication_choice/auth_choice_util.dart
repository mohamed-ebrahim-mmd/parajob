/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 23/11/2025 2:33 PM
 ==================================================================
*/

import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show BuildContext;
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/route_manager/controller/routing_controller.dart';
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart';

Future<void> signInAndLogUserData(BuildContext context) async {
  context.loaderOverlay.show(); // Show loader overlay

  try {
    // Initialize GoogleSignIn with serverClientId
    final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
    await _googleSignIn.initialize(
      clientId: kDebugMode
          ? '587982285191-tgnk9a8n2fuug3e0qssbcint573frhb9.apps.googleusercontent.com'
          : "587982285191-ak57ddc7a2lm0clcfrsn5t9kf8sc59ct.apps.googleusercontent.com",
    );

    // Attempt interactive sign-in
    final GoogleSignInAccount? account = await _googleSignIn.authenticate();

    if (account == null) {
      log("🔴 account == null");
      showSnackBarError("Login canceled", "You canceled the login.");
      return;
    }
    // Request access token with email scope
    const List<String> scopes = ['email'];
    GoogleSignInClientAuthorization? authorization = await account
        .authorizationClient
        .authorizationForScopes(scopes);

    // If null, request interactive authorization
    authorization ??= await account.authorizationClient.authorizeScopes(scopes);

    if (authorization.accessToken.isEmpty) {
      log("🔴 account == null");
      showSnackBarError("Login canceled", "You canceled the login.");
      return;
    }
    // Create request body
    final request = GoogleAuthRequest(accessToken: authorization.accessToken);

    // Call API
    final response = await apiClient.signInWithGoogle(request);

    if (response.isSuccess) {
      final user = response.authData?.user;
      // 1️⃣ Not verified
      if (!(user?.isVerified ?? false)) {
        showSnackBarError("not_verified_title".tr, "not_verified_message".tr);
      }
      // 2️⃣ Verified but profile not completed
      else if (!(user?.isCompleted ?? false)) {
        showSnackBarError(
          "incomplete_profile".tr,
          "please_complete_registration".tr,
        );

        Get.toNamed(
          "${Routes.createAccount}${Routes.createAccountOTP}${Routes.createAccountSetPass}${Routes.createAccountFrontID}",
          arguments: {"tempToken": response.authData?.accessToken ?? "-"},
        );
      }
      // 3️⃣ Completed but not approved
      else if (!(user?.isApproved ?? false)) {
        showSnackBarError(
          "pending_approval_title".tr,
          "pending_approval_message".tr,
        );
      }
      // 4️⃣ Verified + completed + approved → go home
      else {
        final tokenSuccess = await _sendDeviceTokenToBackend(
          "Bearer ${response.authData?.accessToken ?? "-"}",
        );

        if (tokenSuccess) {
          Get.find<RoutingController>().goHomeAsUser(
            user!,
            "Bearer ${response.authData?.accessToken ?? "-"}",
          );
        }
      }
    } else {
      Get.toNamed(Routes.createAccount);
      showSnackBarError("failed_title".tr, "Please create account first");
    }
  } on GoogleSignInException catch (e) {
    log("🔴 GoogleSignInException ${e.code}: ${e.description}");

    switch (e.code) {
      case GoogleSignInExceptionCode.canceled:
        showSnackBarError("Login canceled", "You canceled the login.");
        break;
      case GoogleSignInExceptionCode.clientConfigurationError:
        showSnackBarError(
          "Configuration Error",
          "Google Sign-In is not set up correctly. Check OAuth settings.",
        );
        break;

      case GoogleSignInExceptionCode.unknownError:
        showSnackBarError(
          "Unknown Error",
          e.description ?? "Something went wrong.",
        );
        break;

      default:
        showSnackBarError("Error", "Unexpected error occurred: ${e.code}");
    }
  } catch (e) {
    log("🔴 catch ${e.toString()}");
    showSnackBarApiError();
  } finally {
    context.loaderOverlay.hide(); // Hide loader overlay
  }
}

Future<bool> _sendDeviceTokenToBackend(String userToken) async {
  try {
    String? deviceToken = await FirebaseMessaging.instance.getToken();

    final request = NotificationTokenRequest(deviceToken: deviceToken ?? "-");

    final response = await apiClient.updateDeviceToken(request, userToken);

    if (response.isSuccess) {
      return true;
    } else {
      showSnackBarError("failed".tr, "${response.details.message}");
      return false;
    }
  } catch (e) {
    log("🔴 ${e.toString()}");
    showSnackBarApiError();
    return false;
  }
}
