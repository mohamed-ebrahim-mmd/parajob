import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

class BalanceController extends GetxController {
  // Variable to track the currently selected tab
  final _selectedTab = BalanceTab.month.obs;
  BalanceTab get selectedTab => _selectedTab.value;

  // API call state and data
  var balanceCallState = ApiCallState.loading.obs;
  final balanceData = Rxn<BalanceTransactionsData>();
  final user = Get.find<UserController>();

  @override
  void onInit() {
    super.onInit();
    fetchBalanceTransactions();
  }

  // Function to update the selected tab
  void updateSelectedTab(BalanceTab tab) {
    _selectedTab.value = tab;
    fetchBalanceTransactions();
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
        balanceData.value = response.data!;
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

  // Helper function to get color based on selection
  Color getContainerColor() {
    switch (selectedTab) {
      case BalanceTab.week:
        return Colors.yellow;
      case BalanceTab.month:
        return Colors.green;
      case BalanceTab.year:
        return Colors.red;
    }
  }

  // Get all transactions as a flat list from the Map<String, List<BalanceTransaction>>
  List<BalanceTransaction> get allTransactions {
    return balanceData.value!.transactions.values
        .expand((list) => list)
        .toList();
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
