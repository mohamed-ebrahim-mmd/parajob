import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:para_job/features/profile/balance/widgets/balance_history_widget.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

Future<void> showDeductionDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      double basePadding = context.defaultPadding;

      return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: context.wPct(5)),
        backgroundColor: AppColors.midnightBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.wPct(5)),
        ),
        child: Padding(
          padding: EdgeInsets.all(basePadding * 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  context.wBox(6),
                  Text(
                    'Deduction'.tr,
                    style: TextStyle(
                      color: AppColors.pureWhite,
                      fontSize: context.wPct(6.4),
                      fontWeight: FontWeight.bold,
                      letterSpacing: context.wPct(0.3),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: AppColors.slateGray),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
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
                  children: const [
                    TextSpan(text: 'EGP '),
                    TextSpan(
                      text: '150.00',
                      style: TextStyle(
                        color: AppColors.pureWhite,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: ' will be deducted due to '),
                    TextSpan(
                      text: 'being late',
                      style: TextStyle(
                        color: AppColors.pureWhite,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              context.hBox(2.5),

              /// Deduction card
              TransactionItem(
                logo: Icons.work,
                title: 'Late Submission Penalty',
                company: 'Company XYZ',
                amount: 150.00,
                date: '12 June 2024',
                isPositive: false,
              ),
            ],
          ),
        ),
      );
    },
  );
}
