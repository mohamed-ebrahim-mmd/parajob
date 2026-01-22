import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class NoTransactionsWidget extends StatelessWidget {
  const NoTransactionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'No_transactions_found'.tr,
          style: TextStyle(color: AppColors.lightGray),
        ),
        context.wBox(1),
        Icon(Icons.do_not_disturb_alt_rounded, color: AppColors.lightGray),
      ],
    );
  }
}
