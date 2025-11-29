/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 23/11/2025 2:33 PM
 ==================================================================
*/

import 'dart:developer';
import 'dart:io';

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
    await _googleSignIn.initialize(clientId: getGoogleClientId());

    // Attempt interactive sign-in
    final GoogleSignInAccount? account = await _googleSignIn.authenticate();

    if (account == null) {
      log("🔴 account == null");
      showSnackBarError(
        'google_login_canceled_title'.tr,
        'google_login_canceled_message'.tr,
      );
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
      showSnackBarError(
        'google_login_canceled_title'.tr,
        'google_login_canceled_message'.tr,
      );
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
      showSnackBarError("failed_title".tr, 'Please_create_account_first'.tr);
    }
  } on GoogleSignInException catch (e) {
    log("🔴 GoogleSignInException ${e.code}: ${e.description}");

    switch (e.code) {
      case GoogleSignInExceptionCode.canceled:
        showSnackBarError(
          "google_login_canceled_title".tr,
          "google_login_canceled_message".tr,
        );
        break;
      case GoogleSignInExceptionCode.clientConfigurationError:
        showSnackBarError(
          "google_login_config_error_title".tr,
          'google_login_config_error_message'.tr,
        );
        break;

      case GoogleSignInExceptionCode.unknownError:
        showSnackBarError(
          "google_login_unknown_error_title".tr,
          e.description ?? "google_login_unknown_error_message".tr,
        );
        break;

      default:
        showSnackBarError(
          "error".tr,
          "google_login_unexpected_error".trParams({"code": e.code.toString()}),
        );
    }
  } catch (e) {
    log("🔴 catch ${e.toString()}");
    showSnackBarApiError();
  } finally {
    context.loaderOverlay.hide(); // Hide loader overlay
  }
}

String getGoogleClientId() {
  // ---- iOS Client ID ----
  const iosClientId =
      "587982285191-0eqnatdtp8grom3g71ph1fphs9dad6o7.apps.googleusercontent.com";
  // ---- Android Client IDs ----
  const androidDebugClientId =
      "587982285191-tgnk9a8n2fuug3e0qssbcint573frhb9.apps.googleusercontent.com";
  const androidReleaseClientId =
      "587982285191-ak57ddc7a2lm0clcfrsn5t9kf8sc59ct.apps.googleusercontent.com";

  // --------- PLATFORM LOGIC ----------
  if (Platform.isIOS) {
    return iosClientId;
  }

  if (Platform.isAndroid) {
    if (kDebugMode) {
      return androidDebugClientId;
    } else {
      return androidReleaseClientId;
    }
  }
  log("⚠️ Unknown platform — no client ID");
  return "";
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
