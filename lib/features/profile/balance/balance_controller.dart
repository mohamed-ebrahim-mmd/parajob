import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'balance_tab_enum.dart';

class BalanceController extends GetxController {
  // Variable to track the currently selected tab
  final _selectedTab = BalanceTab.Month.obs;
  BalanceTab get selectedTab => _selectedTab.value;

  // Function to update the selected tab
  void updateSelectedTab(BalanceTab tab) {
    _selectedTab.value = tab;
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
}
