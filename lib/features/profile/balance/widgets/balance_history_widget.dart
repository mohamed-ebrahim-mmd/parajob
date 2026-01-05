import 'package:flutter/material.dart';
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
          _SectionTitle(title: 'From 1 to 7 Sep'),
          _TransactionItem(
            logo: Icons.music_note,
            company: 'Spotify',
            title: 'Supervisor',
            amount: '+ EGP 1500.00',
            date: '9 March',
            isPositive: true,
          ),
          _TransactionItem(
            logo: Icons.music_note,
            company: 'Spotify',
            title: 'Supervisor',
            amount: '- EGP 150.00',
            date: '9 March',
            isPositive: false,
          ),
          _TransactionItem(
            logo: Icons.album,
            company: 'Anghami',
            title: 'Usher',
            amount: '+ EGP 500.00',
            date: '9 March',
            isPositive: true,
          ),
          SizedBox(height: 24),
          _SectionTitle(title: 'From 16 to 22 Sep'),
          _TransactionItem(
            logo: Icons.work,
            company: 'Red Bull',
            title: 'Intern',
            amount: '+ EGP 600000000000.00',
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
  final String amount;
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
                Row(
                  children: [
                    Text(
                      '$title ',
                      style: TextStyle(
                        color: isPositive
                            ? AppColors.silverGray
                            : Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'at',
                      style: TextStyle(
                        color: isPositive
                            ? AppColors.silverGray
                            : Colors.redAccent,
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  company,
                  style: const TextStyle(
                    color: AppColors.silverGray,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          /// Amount & Date
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: TextStyle(
                  color: amountColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 6),
              Row(
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
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 11),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.silverGray,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
