/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 23/11/2025 2:33 PM
 ==================================================================
*/
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show BuildContext;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loader_overlay/loader_overlay.dart';
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
    //todo call the endpoint to check the flow of the user
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
