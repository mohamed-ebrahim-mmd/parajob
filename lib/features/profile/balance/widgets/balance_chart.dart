import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/profile/balance/balance_controller.dart';

class BalanceChart extends StatelessWidget {
  BalanceChart({super.key});

  static const double _chartHeightFactor = 0.25;
  static const double _leftPadding = 24;
  static const double _defaultPadding = 16;
  final controller = Get.find<BalanceController>();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * _chartHeightFactor,
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          _leftPadding,
          _defaultPadding,
          _defaultPadding,
          _defaultPadding,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF0E141B),
          borderRadius: BorderRadius.circular(16),
        ),
        child: LineChart(
          controller.chartData(
            chart: controller.balanceData!.chart,
            selectedTab: controller.selectedTab,
          ),
        ),
      ),
    );
  }
}
