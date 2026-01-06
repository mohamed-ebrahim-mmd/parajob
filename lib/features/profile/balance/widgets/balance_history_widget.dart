import 'package:flutter/material.dart';
import 'package:para_job/features/profile/balance/models/transaction_model.dart';
import 'package:para_job/features/profile/balance/widgets/balance_alert_dialog.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

/// Dummy data model for transaction items

/// Get dummy transactions data
List<TransactionDummy> _dummyTransactions(BuildContext context) => [
  TransactionDummy(
    logo: Icons.music_note,
    company: 'Spotify',
    title: 'Supervisor',
    amount: 1500.00,
    date: '9 March',
    isPositive: true,
    onTap: () {
      showDeductionDialog(context);
    },
  ),
  TransactionDummy(
    logo: Icons.music_note,
    company: 'Spotify',
    title: 'Supervisor',
    amount: 150.00,
    date: '9 March',
    isPositive: false,
    onTap: () {
      showDeductionDialog(context);
    },
  ),
  TransactionDummy(
    logo: Icons.album,
    company: 'Andasdsadsadsadsaghami',
    title: 'Usher',
    amount: 500.00,
    date: '9 March',
    isPositive: true,
    onTap: () {
      showDeductionDialog(context);
    },
  ),
  TransactionDummy(
    logo: Icons.work,
    company: 'Red Bull',
    title: 'Intern',
    amount: 600.00,
    date: '9 March',
    isPositive: true,
    onTap: () {
      showDeductionDialog(context);
    },
  ),
];

class BalanceHistorySection extends StatelessWidget {
  const BalanceHistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final transactions = _dummyTransactions(context);

    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.all(context.wPct(3)),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final item = transactions[index];

          return TransactionItem(
            logo: item.logo,
            title: item.title,
            company: item.company,
            amount: item.amount,
            date: item.date,
            isPositive: item.isPositive,
            onTap: item.onTap,
          );
        },
      ),
    );
  }
}

class TransactionItem extends StatelessWidget {
  final IconData logo;
  final String title;
  final String company;
  final double amount;
  final String date;
  final bool isPositive;
  final Function()? onTap;

  const TransactionItem({
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
      behavior: onTap != null
          ? HitTestBehavior.opaque
          : HitTestBehavior.deferToChild,
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: context.hPct(1),
          horizontal: context.wPct(1),
        ),
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
