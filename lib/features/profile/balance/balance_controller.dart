import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:para_job/features/profile/balance/widgets/balance_alert_dialog.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

class BalanceController extends GetxController {
  // Variable to track the currently selected tab
  BalanceTab selectedTab = BalanceTab.month;

  // API call state and data
  var balanceCallState = ApiCallState.loading.obs;

  BalanceTransactionsData? balanceData;
  final user = Get.find<UserController>();

  @override
  void onInit() {
    super.onInit();
    fetchBalanceTransactions();
  }

  // Function to update the selected tab
  void updateSelectedTab(BalanceTab tab) {
    selectedTab = tab;
    fetchBalanceTransactions();
  }

  // Handle transaction tap
  void onTransactionTap(BuildContext context, BalanceTransaction item) {
    final isPositive = item.amount >= 0;

    if (isPositive) return;

    showDeductionDialog(
      context,
      amount: item.amount,
      reason: item.reason,
      title: item.jobTitle,
      company: item.company.name,
      date: selectedTab.formatDate(item.occurredAt),
      logoUrl: item.company.logo,
    );
  }

  // Fetch balance transactions from API
  Future<void> fetchBalanceTransactions() async {
    balanceCallState.value = ApiCallState.loading;

    try {
      final response = await apiClient.getBalanceTransactions(
        token: user.token!,
        range: selectedTab.value.toLowerCase(),
      );

      if (response.isSuccess && response.data != null) {
        log("🟢 fetchBalanceTransactions isSuccess");
        balanceData = response.data!;
        balanceCallState.value = ApiCallState.success;
      } else {
        log("🔴 fetchBalanceTransactions failed: ${response.details?.message}");
        balanceCallState.value = ApiCallState.failure;
      }
    } catch (e) {
      log("🔴 fetchBalanceTransactions error: $e");
      balanceCallState.value = ApiCallState.failure;
    }
  }
}

enum BalanceTab { week, month, year }

extension BalanceTabExtension on BalanceTab {
  String get value {
    return name;
  }

  String get displayName {
    switch (this) {
      case BalanceTab.week:
        return 'balance_tab_week'.tr;
      case BalanceTab.month:
        return 'balance_tab_month'.tr;
      case BalanceTab.year:
        return 'balance_tab_year'.tr;
    }
  }

  String formatDate(String isoDate) {
    final date = DateTime.tryParse(isoDate);
    if (date == null) return '';
    return DateFormat('d MMMM').format(date);
  }
}
