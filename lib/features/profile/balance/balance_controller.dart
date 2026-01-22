import 'dart:developer';
import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:para_job/features/profile/balance/widgets/balance_alert_dialog.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
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

  // Get all transactions as a flat list from the Map<String, List<BalanceTransaction>>
  List<BalanceTransaction> get allTransactions {
    return balanceData!.transactions.values.expand((list) => list).toList();
  }

  // Helper methods moved from BalanceChart widget
  LineChartData chartData({required List<BalanceChartItem> chart}) {
    if (chart.isEmpty) return emptyChart();

    final spots = buildSpots(chart);
    final labels = buildLabels(chart, selectedTab);
    final yAxis = calculateYAxis(chart);
    final xAxis = calculateXAxis(chart.length);

    return LineChartData(
      clipData: const FlClipData.all(),
      minX: xAxis.min,
      maxX: xAxis.max,
      minY: yAxis.min,
      maxY: yAxis.max,
      gridData: gridData(),
      titlesData: titlesData(
        labels: labels,
        yInterval: yAxis.step,
        selectedTab: selectedTab,
      ),
      borderData: FlBorderData(show: false),
      lineBarsData: [line(spots)],
    );
  }

  List<FlSpot> buildSpots(List<BalanceChartItem> chart) =>
      List.generate(chart.length, (i) => FlSpot(i.toDouble(), chart[i].value));

  List<String> buildLabels(List<BalanceChartItem> chart, BalanceTab tab) =>
      chart.map((e) => formatLabel(e.label, tab)).toList();

  LineChartBarData line(List<FlSpot> spots) {
    return LineChartBarData(
      spots: spots,
      isCurved: true,
      preventCurveOverShooting: true,
      barWidth: 2.5,
      color: AppColors.aquaTeal,

      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(
        show: true,
        color: AppColors.aquaTeal.withValues(alpha: 0.1),
      ),
    );
  }

  YAxis calculateYAxis(List<BalanceChartItem> chart) {
    final values = chart.map((e) => e.value).toList();
    final minValue = values.reduce(math.min);
    final maxValue = values.reduce(math.max);

    final range = maxValue - minValue == 0
        ? maxValue.abs()
        : maxValue - minValue;

    final step = niceStep(range);

    final minY = math.max(0, (minValue / step).floorToDouble() * step);
    final maxY = (maxValue / step).ceilToDouble() * step;

    return YAxis(min: minY.toDouble(), max: maxY.toDouble(), step: step);
  }

  XAxis calculateXAxis(int length) {
    final maxX = length > 1 ? length - 1.0 : 1.0;
    return XAxis(min: 0, max: maxX + 0.5);
  }

  FlTitlesData titlesData({
    required List<String> labels,
    required double yInterval,
    required BalanceTab selectedTab,
  }) {
    return FlTitlesData(
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 64,
          getTitlesWidget: (value, _) => Text(
            'EGP ${value.toInt()}',
            style: const TextStyle(color: Colors.white54, fontSize: 12),
          ),
        ),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,

          getTitlesWidget: (value, _) {
            if (value % 1 != 0) return const SizedBox();

            final index = value.toInt();

            return Padding(
              padding: const EdgeInsets.only(top: 8),
              child: SizedBox(
                width: 40,
                child: Text(
                  labels[index],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white54, fontSize: 11),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  FlGridData gridData() => FlGridData(
    show: true,
    getDrawingHorizontalLine: (_) =>
        FlLine(color: Colors.white10, strokeWidth: 1),
    getDrawingVerticalLine: (_) =>
        FlLine(color: Colors.white10, strokeWidth: 1),
  );

  LineChartData emptyChart() => LineChartData(
    lineBarsData: const [],
    titlesData: const FlTitlesData(show: false),
    gridData: const FlGridData(show: false),
    borderData: FlBorderData(show: false),
  );

  String formatLabel(String raw, BalanceTab frame) {
    final date = DateTime.tryParse(raw);
    if (date == null) return raw;

    switch (frame) {
      case BalanceTab.week:
        return DateFormat('EEE').format(date);
      case BalanceTab.month:
        return DateFormat('d MMM').format(date);
      case BalanceTab.year:
        return 'Q${((date.month - 1) ~/ 3) + 1}';
    }
  }

  double niceStep(double range) {
    if (range <= 0) return 1;

    final rough = range / 4;
    final magnitude = math
        .pow(10, (math.log(rough) / math.ln10).floor())
        .toDouble();
    final residual = rough / magnitude;

    if (residual >= 5) return 5 * magnitude;
    if (residual >= 2) return 2 * magnitude;
    return magnitude;
  }
}

// Models moved from BalanceChart widget
class YAxis {
  final double min;
  final double max;
  final double step;
  const YAxis({required this.min, required this.max, required this.step});
}

class XAxis {
  final double min;
  final double max;
  const XAxis({required this.min, required this.max});
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
