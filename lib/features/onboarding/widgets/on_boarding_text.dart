//Mary Mark ||  mary.mark@moselaymd.com || Sun Mar 01 2026 02:57:40

import 'package:flutter/material.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class onBoardingText extends StatelessWidget {
  final int pageIndex;
  const onBoardingText({super.key, required this.pageIndex});

  @override
  Widget build(BuildContext context) {
    switch (pageIndex) {
      case 0:
        return RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'Browe to find the',
            style: TextStyle(
              color: AppColors.pureWhite,
              fontSize: context.wPct(4.5),
              fontWeight: FontWeight.w600,
            ),
            children: [
              TextSpan(
                text: ' perfect job',
                style: TextStyle(color: AppColors.aquaTeal),
              ),
              TextSpan(text: ' for \n you.'),
            ],
          ),
        );

      case 1:
        return RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'Finad all the ',
            style: TextStyle(
              color: AppColors.pureWhite,
              fontSize: context.wPct(4.5),
              fontWeight: FontWeight.w600,
            ),
            children: [
              TextSpan(
                text: 'job details',
                style: TextStyle(color: AppColors.aquaTeal),
              ),
              TextSpan(text: ' you might \n need.'),
            ],
          ),
        );

      case 2:
        return RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'View your approved jobs and sign \n the ',
            style: TextStyle(
              color: AppColors.pureWhite,
              fontSize: context.wPct(4.5),
              fontWeight: FontWeight.w600,
            ),
            children: [
              TextSpan(
                text: 'job contract',
                style: TextStyle(color: AppColors.aquaTeal),
              ),
              TextSpan(text: "."),
            ],
          ),
        );

      default:
        return const Text("Browe to find the perfect job for you.");
    }
  }
}

