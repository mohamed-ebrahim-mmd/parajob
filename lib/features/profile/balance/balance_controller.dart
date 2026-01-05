import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BalanceController extends GetxController {
  // Variable to track the currently selected tab
  final _selectedTab = 'Month'.obs;
  String get selectedTab => _selectedTab.value;

  // Function to update the selected tab
  void updateSelectedTab(String tab) {
    _selectedTab.value = tab;
  }

  // Helper function to get color based on selection
  Color getContainerColor() {
    switch (selectedTab) {
      case 'Week':
        return Colors.yellow;
      case 'Month':
        return Colors.green;
      case 'Year':
        return Colors.red;
      default:
        return Colors.transparent;
    }
  }
}
