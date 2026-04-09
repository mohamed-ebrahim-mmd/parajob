import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:para_job/features/profile/balance/widgets/balance_history_item.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

Future<void> showDeductionDialog(
  BuildContext context, {
  required double amount,
  required String reason,
  required String title,
  required String company,
  required String date,
  String logoUrl = '',
}) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: context.wPct(3)),
        backgroundColor: AppColors.dialogBackgroundDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.wPct(3)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.defaultPadding,

            vertical: context.hPct(2),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Header
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.close, color: AppColors.slateGray),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              Text(
                'Deduction'.tr,
                style: TextStyle(
                  color: AppColors.pureWhite,
                  fontSize: context.wPct(6.4),
                  fontWeight: FontWeight.bold,
                  letterSpacing: context.wPct(0.3),
                ),
              ),
              context.hBox(2.5),

              /// Message
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    color: AppColors.lightSilverGray,
                    fontSize: context.wPct(5),
                  ),
                  children: [
                    TextSpan(
                      text: amount.abs().toStringAsFixed(2),
                      style: const TextStyle(
                        color: AppColors.pureWhite,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: ' ${'balance_currency'.tr}'),

                    TextSpan(text: ' ${'will_be_deducted_due_to'.tr} '),

                    TextSpan(
                      text: reason,
                      style: const TextStyle(
                        color: AppColors.pureWhite,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              context.hBox(2.5),

              /// Deduction card
              BalanceHistoryItem(
                logoUrl: logoUrl,
                title: title,
                company: company,
                amount: amount.abs(),
                date: date,
                isPositive: false,
              ),
            ],
          ),
        ),
      );
    },
  );
}
