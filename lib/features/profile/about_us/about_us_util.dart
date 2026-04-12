/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 12/04/2026 11:56 AM
 ==================================================================
*/

import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

Future<void> openInstagram() async {
  final uri = Uri.parse('https://www.instagram.com/parajob_eg/');
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

Future<void> openFacebook() async {
  final uri = Uri.parse('https://www.facebook.com/p/Parajob-61552287592129/');
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

Future<void> openX() async {
  final uri = Uri.parse('https://x.com/home');
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

Future<void> openAppStore() async {
  const _androidAppUrl =
      'https://play.google.com/store/apps/details?id=com.sha8alny.shaghalny&hl=ar';
  const _iosAppUrl = 'https://apps.apple.com/eg/app/parajob/id6468668018?l=ar';

  final url = Platform.isIOS ? _iosAppUrl : _androidAppUrl;
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
