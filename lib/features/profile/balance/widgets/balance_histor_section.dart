import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:para_job/features/profile/balance/balance_controller.dart';
import 'package:para_job/features/profile/balance/widgets/balance_history_item.dart';
import 'package:para_job/features/profile/balance/widgets/no_transactions.dart';
import 'package:para_job/packages/api_client/src/models/responses/balance_transactions_response.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class BalanceHistorySection extends StatelessWidget {
  BalanceHistorySection({super.key});

  final controller = Get.find<BalanceController>();

  bool get isEmpty => (controller.balanceData?.transactions ?? {}).isEmpty;

  Map<String, List<BalanceTransaction>> get transactionsByDate =>
      controller.balanceData?.transactions ??
      <String, List<BalanceTransaction>>{};
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: transactionsByDate.length,
        itemBuilder: (context, index) {
          final entry = transactionsByDate.entries.elementAt(index);
          final transactions = entry.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: context.defaultPadding),
                child: Text(
                  entry.key,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              if (transactions.isEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.defaultPadding,
                    vertical: context.defaultPadding,
                  ),
                  child: const NoTransactionsWidget(),
                )
              else
                ListView.builder(
                  itemCount: transactions.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, itemIndex) {
                    final item = transactions[itemIndex];
                    final isPositive = item.amount >= 0;

                    return BalanceHistoryItem(
                      logoUrl: item.company.logo,
                      title: item.jobTitle,
                      company: item.company.name,
                      amount: item.amount.abs(),
                      date: controller.selectedTab.formatDate(item.occurredAt),
                      isPositive: isPositive,
                      onTap: () => controller.onTransactionTap(context, item),
                    );
                  },
                ),
            ],
          );
        },
      ),
    );
  }
}
