import 'package:get/get.dart';

class BalanceController extends GetxController {
  var selectedPeriod = 'Month'.obs; // Default to Month

  void selectPeriod(String period) {
    selectedPeriod.value = period;
  }
}
