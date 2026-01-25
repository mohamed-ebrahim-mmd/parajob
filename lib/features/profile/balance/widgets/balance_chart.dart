import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/profile/balance/balance_controller.dart';
import 'package:para_job/features/profile/balance/util/get_chart_data.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class BalanceChart extends StatelessWidget {
  BalanceChart({super.key});

  final controller = Get.find<BalanceController>();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          context.wPct(3),
          context.hPct(2),
          context.wPct(2.5),
          context.hPct(2),
        ),
        child: LineChart(chartData(chart: controller.balanceData!.chart)),
      ),
    );
  }
}
