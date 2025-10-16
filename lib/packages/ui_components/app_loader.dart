/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 13/08/2025 2:11 PM
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        constraints: BoxConstraints(
          minHeight: context.wPct(15),
          minWidth: context.wPct(15),
        ),

        color: AppColors.aquaTeal,
      ),
    );
  }
}
