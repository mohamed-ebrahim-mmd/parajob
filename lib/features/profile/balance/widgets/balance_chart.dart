import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/profile/balance/balance_controller.dart';
import 'package:para_job/features/profile/balance/util/get_chart_data.dart';

class BalanceChart extends StatelessWidget {
  BalanceChart({super.key});

  static const double _chartHeightFactor = 0.25;
  static const double _leftPadding = 24;
  static const double _defaultPadding = 16;
  final controller = Get.find<BalanceController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * _chartHeightFactor,
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          _leftPadding,
          _defaultPadding,
          _defaultPadding,
          _defaultPadding,
        ),

        child: LineChart(
          chartData(
            chart: controller.balanceData!.chart,
            selectedTab: controller.selectedTab,
          ),
        ),
      ),
    );
  }
}
