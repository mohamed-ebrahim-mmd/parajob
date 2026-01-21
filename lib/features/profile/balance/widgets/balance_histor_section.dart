import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:para_job/features/profile/balance/balance_controller.dart';
import 'package:para_job/features/profile/balance/widgets/balance_history_item.dart';
import 'package:para_job/packages/api_client/src/models/responses/balance_transactions_response.dart';

/// Dummy data model for transaction items

class BalanceHistorySection extends StatelessWidget {
  final controller = Get.find<BalanceController>();

  BalanceHistorySection({super.key});

  List<BalanceTransaction> get transactions => controller.allTransactions;
  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return const Center(
        child: Text(
          'No transactions found',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final item = transactions[index];

          final isPositive = item.amount >= 0;

          return BalanceHistoryItem(
            logoUrl: item.company.logo,
            title: item.jobTitle,
            company: item.company.name,
            amount: item.amount.abs(),
            date: formatDate(item.occurredAt),
            isPositive: isPositive,
            onTap: () {
              // optional: show details dialog
            },
          );
        },
      ),
    );
  }

  // Helper function to format date
  String formatDate(String isoDate) {
    final date = DateTime.tryParse(isoDate);
    if (date == null) return '';
    return DateFormat('d MMMM').format(date);
  }
}
