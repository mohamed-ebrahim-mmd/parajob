import 'package:get/get.dart';

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
}
