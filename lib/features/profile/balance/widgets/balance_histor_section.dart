import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:para_job/features/profile/balance/balance_controller.dart';
import 'package:para_job/features/profile/balance/widgets/balance_history_item.dart';

/// Dummy data model for transaction items

class BalanceHistorySection extends StatelessWidget {
  const BalanceHistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    //get put
    final controller = Get.find<BalanceController>();

    final transactions = controller.dummyTransactions(context);

    return Expanded(
      child: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final item = transactions[index];

          return BalanceHistoryItem(
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
