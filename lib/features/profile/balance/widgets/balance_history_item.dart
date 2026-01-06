// Karim Toson || kareemtoson1@gmail.com || Tue Jan 06 2026 14:46:21

import 'package:flutter/material.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class BalanceHistoryItem extends StatelessWidget {
  final IconData logo;
  final String title;
  final String company;
  final double amount;
  final String date;
  final bool isPositive;
  final Function()? onTap;

  const BalanceHistoryItem({
    super.key,
    required this.logo,
    required this.title,
    required this.company,
    required this.amount,
    required this.date,
    required this.isPositive,

    this.onTap,
  });

  /// Get border color based on transaction type
  Color get borderColor =>
      isPositive ? AppColors.silverGray : AppColors.coralRed;

  /// Get amount text color based on transaction type
  Color get amountColor =>
      isPositive ? AppColors.silverGray : AppColors.coralRed;

  /// Get title text color based on transaction type
  Color get titleColor =>
      isPositive ? AppColors.silverGray : AppColors.coralRed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        margin: EdgeInsets.symmetric(vertical: context.hPct(1)),
        padding: EdgeInsets.all(context.wPct(3.5)),
        decoration: BoxDecoration(
          color: AppColors.darkCharcoal,
          borderRadius: BorderRadius.circular(context.wPct(4)),
          border: Border.all(color: borderColor, width: context.wPct(0.4)),
        ),
        child: Row(
          children: [
            Container(
              width: context.wPct(11),
              height: context.wPct(11),
              decoration: BoxDecoration(
                color: AppColors.darkBackground,
                borderRadius: BorderRadius.circular(context.wPct(3)),
              ),
              child: Icon(logo, color: AppColors.pureWhite),
            ),

            context.wBox(3),

            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$title at',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: titleColor,
                      fontWeight: FontWeight.bold,
                      fontSize: context.wPct(4),
                    ),
                  ),
                  context.hBox(0.5),
                  Text(
                    company,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.silverGray,
                      fontSize: context.wPct(3.5),
                    ),
                  ),
                ],
              ),
            ),

            context.wBox(2),

            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${isPositive ? '+' : '-'} EGP $amount',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: TextStyle(
                      color: amountColor,
                      fontWeight: FontWeight.bold,
                      fontSize: context.wPct(4.1),
                    ),
                  ),
                  context.hBox(0.75),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: context.wPct(3.2),
                        color: AppColors.silverGray,
                      ),
                      context.wBox(1),
                      Flexible(
                        child: Text(
                          date,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.silverGray,
                            fontSize: context.wPct(3.3),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
