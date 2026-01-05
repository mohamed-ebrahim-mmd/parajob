import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:para_job/packages/themeing/app_colors.dart';

class BalanceHistorySection extends StatelessWidget {
  const BalanceHistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
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
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF14181F),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: Row(
        children: [
          /// Logo
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(logo, color: Colors.white),
          ),

          const SizedBox(width: 12),

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
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Tooltip(
                  message: company,
                  child: Text(
                    company,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.silverGray,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// Amount & Date (Fixed width)
          SizedBox(
            width: 130,
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
                      fontSize: 17,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: AppColors.silverGray,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      date,
                      style: const TextStyle(
                        color: AppColors.silverGray,
                        fontSize: 14,
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
