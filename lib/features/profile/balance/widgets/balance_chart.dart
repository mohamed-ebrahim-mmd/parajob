import 'dart:math' as math;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:para_job/features/profile/balance/balance_controller.dart';
import 'package:para_job/packages/api_client/src/models/responses/balance_transactions_response.dart';

class BalanceChart extends StatelessWidget {
  const BalanceChart({super.key});

  @override
  Widget build(BuildContext context) {
    final BalanceController controller = Get.find<BalanceController>();
    final chart = controller.balanceData?.chart ?? const [];

    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.25,
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 16, 16, 16),
        decoration: BoxDecoration(
          color: const Color(0xFF0E141B),
          borderRadius: BorderRadius.circular(16),
        ),
        child: LineChart(_buildChartData(chart)),
      ),
    );
  }

  LineChartData _buildChartData(List<BalanceChartItem> chart) {
    if (chart.isEmpty) {
      return LineChartData(
        lineBarsData: const [],
        titlesData: const FlTitlesData(show: false),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
      );
    }

    final BalanceController controller = Get.find<BalanceController>();
    final spots = List<FlSpot>.generate(
      chart.length,
      (i) => FlSpot(i.toDouble(), chart[i].value),
    );

    final labels = chart
        .map((e) => _formatLabel(e.label, controller.selectedTab))
        .toList();

    final values = chart.map((e) => e.value).toList();
    final minValue = values.reduce(math.min);
    final maxValue = values.reduce(math.max);

    final range = maxValue - minValue == 0
        ? maxValue.abs()
        : maxValue - minValue;
    final yAxisStep = _niceStep(range);

    final calculatedMinY = (minValue / yAxisStep).floor() * yAxisStep;
    final minY = calculatedMinY < 0 ? 0.0 : calculatedMinY;
    final maxY = (maxValue / yAxisStep).ceil() * yAxisStep;
    final interval = yAxisStep;

    final maxX = (chart.length - 1).toDouble();
    final safeMaxX = maxX == 0 ? 1.0 : maxX;

    // Add horizontal padding to prevent line from going outside chart
    final minX = -0.5;
    final adjustedMaxX = safeMaxX + 0.5;

    final maxLabels = controller.selectedTab == BalanceTab.week ? 7 : 5;
    final step = (labels.length / maxLabels).ceil();

    return LineChartData(
      clipData: const FlClipData.all(),
      gridData: FlGridData(
        show: true,
        getDrawingHorizontalLine: (_) =>
            FlLine(color: Colors.white10, strokeWidth: 1),
        getDrawingVerticalLine: (_) =>
            FlLine(color: Colors.white10, strokeWidth: 1),
      ),
      titlesData: FlTitlesData(
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: interval,
            reservedSize: 64,
            getTitlesWidget: (value, _) {
              return Text(
                'EGP ${value.toInt()}',
                style: const TextStyle(color: Colors.white54, fontSize: 12),
              );
            },
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, _) {
              final index = value.toInt();
              if (index < 0 || index >= labels.length) {
                return const SizedBox();
              }

              if (controller.selectedTab != BalanceTab.week) {
                if (index % step != 0 && index != labels.length - 1) {
                  return const SizedBox();
                }
              }

              return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  labels[index],
                  style: const TextStyle(color: Colors.white54, fontSize: 11),
                ),
              );
            },
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      minX: minX,
      maxX: adjustedMaxX,
      minY: minY,
      maxY: maxY,
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          preventCurveOverShooting: true,
          barWidth: 2.5,
          color: const Color(0xFF2FE3C2),
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                const Color(0xFF2FE3C2).withOpacity(0.25),
                Colors.transparent,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
    );
  }

  String _formatLabel(String raw, BalanceTab frame) {
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

  double _niceStep(double range) {
    if (range <= 0) return 1.0;

    final roughStep = range / 4;
    final magnitude = math
        .pow(10, (math.log(roughStep) / math.ln10).floor())
        .toDouble();
    final residual = roughStep / magnitude;

    if (residual >= 5) return (5 * magnitude).toDouble();
    if (residual >= 2) return (2 * magnitude).toDouble();
    return magnitude.toDouble();
  }
}
