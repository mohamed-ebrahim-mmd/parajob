import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class BalanceHistorySection extends StatelessWidget {
  const BalanceHistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(context.wPct(3)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TransactionItem(
            logo: Icons.music_note,
            company: 'Spotify',
            title: 'Supervisor',
            amount: 1500.00,
            date: '9 March',
            isPositive: true,
          ),
          _TransactionItem(
            logo: Icons.music_note,
            company: 'Spotify',
            title: 'Supervisor',
            amount: 150.00,
            date: '9 March',
            isPositive: false,
          ),
          _TransactionItem(
            logo: Icons.album,
            company: 'Andasdsadsadsasdaghami',
            title: 'Usher',
            amount: 500.00,
            date: '9 March',
            isPositive: true,
          ),
          _TransactionItem(
            logo: Icons.work,
            company: 'Red Bull',
            title: 'Intedsadsadssfafsafasrn',
            amount:
                6000000000000000000000000000000000000000000000000000000000.00,
            date: '9 March',
            isPositive: true,
          ),
        ],
      ),
    );
  }
}

class _TransactionItem extends StatelessWidget {
  final IconData logo;
  final String title;
  final String company;
  final double amount;
  final String date;
  final bool isPositive;

  const _TransactionItem({
    required this.logo,
    required this.title,
    required this.company,
    required this.amount,
    required this.date,
    required this.isPositive,
  });

  /// Format amount with commas
  String get formattedAmount {
    final formatter = NumberFormat.currency(
      locale: 'en',
      symbol: 'EGP ',
      decimalDigits: 2,
    );
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = isPositive ? AppColors.silverGray : Colors.redAccent;
    final amountColor = isPositive ? AppColors.silverGray : Colors.redAccent;

    return Container(
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
          /// Logo
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

          /// Job Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Tooltip(
                  message: '$title at $company',
                  child: Text(
                    '$title at',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: isPositive
                          ? AppColors.silverGray
                          : Colors.redAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: context.wPct(4),
                    ),
                  ),
                ),
                context.hBox(0.5),
                Tooltip(
                  message: company,
                  child: Text(
                    company,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.silverGray,
                      fontSize: context.wPct(3.5),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// Amount & Date (Fixed width)
          SizedBox(
            width: context.wPct(32.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Tooltip(
                  message: '${isPositive ? '+' : '-'} $formattedAmount',
                  child: Text(
                    '${isPositive ? '+' : '-'} $formattedAmount',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: TextStyle(
                      color: amountColor,
                      fontWeight: FontWeight.bold,
                      fontSize: context.wPct(4.25),
                    ),
                  ),
                ),
                context.hBox(0.75),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: context.wPct(3.5),
                      color: AppColors.silverGray,
                    ),
                    SizedBox(width: context.wPct(1)),
                    Text(
                      date,
                      style: TextStyle(
                        color: AppColors.silverGray,
                        fontSize: context.wPct(3.5),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
