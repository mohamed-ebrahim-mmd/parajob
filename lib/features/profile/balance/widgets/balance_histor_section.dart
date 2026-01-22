import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:para_job/features/profile/balance/balance_controller.dart';
import 'package:para_job/features/profile/balance/widgets/balance_alert_dialog.dart';
import 'package:para_job/features/profile/balance/widgets/balance_history_item.dart';
import 'package:para_job/packages/api_client/src/models/responses/balance_transactions_response.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

/// Dummy data model for transaction items
class BalanceHistorySection extends StatelessWidget {
  BalanceHistorySection({super.key});

  final controller = Get.find<BalanceController>();

  bool get isEmpty =>
      (controller.balanceData.value?.transactions ?? {}).isEmpty;

  Map<String, List<BalanceTransaction>> get transactionsByDate =>
      controller.balanceData.value?.transactions ??
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
                  padding: const EdgeInsets.only(left: 12, bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'No_transactions_found'.tr,
                        style: TextStyle(color: AppColors.lightGray),
                      ),
                      Icon(
                        Icons.do_not_disturb_alt_rounded,
                        color: AppColors.lightGray,
                      ),
                    ],
                  ),
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
                      onTap: isPositive
                          ? null
                          : () {
                              showDeductionDialog(
                                context,
                                amount: item.amount,
                                reason: item.reason,
                                title: item.jobTitle,
                                company: item.company.name,
                                date: controller.selectedTab.formatDate(
                                  item.occurredAt,
                                ),
                                logoUrl: item.company.logo,
                              );
                            },
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
