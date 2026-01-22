import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:para_job/features/profile/balance/widgets/balance_alert_dialog.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

class BalanceController extends GetxController {
  // Variable to track the currently selected tab
  final _selectedTab = BalanceTab.Month.obs;
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
      case BalanceTab.Week:
        return Colors.yellow;
      case BalanceTab.Month:
        return Colors.green;
      case BalanceTab.Year:
        return Colors.red;
    }
  }

  // Get all transactions as a flat list from the Map<String, List<BalanceTransaction>>
  List<BalanceTransaction> get allTransactions {
    return balanceData.value!.transactions.values
        .expand((list) => list)
        .toList();
  }

  /// Get dummy transactions data
  List<TransactionDummy> dummyTransactions(BuildContext context) => [
    TransactionDummy(
      logo: Icons.music_note,
      company: 'Spotify',
      title: 'Supervisor',
      amount: 1500.00,
      date: '9 March',
      isPositive: true,
      onTap: () {
        showDeductionDialog(
          context,
          amount: 1500.00,
          reason: 'Bonus adjustment',
          title: 'Supervisor',
          company: 'Spotify',
          date: '9 March',
          logoUrl: '',
        );
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
        showDeductionDialog(
          context,
          amount: 150.00,
          reason: 'Late submission',
          title: 'Supervisor',
          company: 'Spotify',
          date: '9 March',
          logoUrl: '',
        );
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
        showDeductionDialog(
          context,
          amount: 500.00,
          reason: 'Performance adjustment',
          title: 'Usher',
          company: 'Andasdsadsadsadsaghami',
          date: '9 March',
          logoUrl: '',
        );
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
        showDeductionDialog(
          context,
          amount: 600.00,
          reason: 'Adjustment',
          title: 'Intern',
          company: 'Red Bull',
          date: '9 March',
          logoUrl: '',
        );
      },
    ),
  ];
}

class TransactionDummy {
  final IconData logo;
  final String title;
  final String company;
  final double amount;
  final String date;
  final bool isPositive;
  final VoidCallback? onTap;

  const TransactionDummy({
    required this.logo,
    required this.title,
    required this.company,
    required this.amount,
    required this.date,
    required this.isPositive,
    this.onTap,
  });
}

enum BalanceTab { Week, Month, Year }

extension BalanceTabExtension on BalanceTab {
  String get value {
    switch (this) {
      case BalanceTab.Week:
        return 'Week';
      case BalanceTab.Month:
        return 'Month';
      case BalanceTab.Year:
        return 'Year';
    }
  }

  static BalanceTab fromString(String value) {
    switch (value.toLowerCase()) {
      case 'week':
        return BalanceTab.Week;
      case 'month':
        return BalanceTab.Month;
      case 'year':
        return BalanceTab.Year;
      default:
        return BalanceTab.Month;
    }
  }

  String get displayName {
    switch (this) {
      case BalanceTab.Week:
        return 'balance_tab_week'.tr;
      case BalanceTab.Month:
        return 'balance_tab_month'.tr;
      case BalanceTab.Year:
        return 'balance_tab_year'.tr;
    }
  }

  String formatDate(String isoDate) {
    final date = DateTime.tryParse(isoDate);
    if (date == null) return '';
    return DateFormat('d MMMM').format(date);
  }
}
