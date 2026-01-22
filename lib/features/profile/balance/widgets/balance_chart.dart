import 'dart:math' as math;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:para_job/features/profile/balance/balance_controller.dart';
import 'package:para_job/packages/api_client/src/models/responses/balance_transactions_response.dart';

class BalanceChart extends StatelessWidget {
  const BalanceChart({super.key});

  static const double _chartHeightFactor = 0.25;
  static const double _leftPadding = 24;
  static const double _defaultPadding = 16;
  static const double _xPadding = 0.5;
  static const double _yAxisReservedSize = 64;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BalanceController>();
    final chart = controller.balanceData?.chart ?? const [];

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
          _chartData(chart: chart, selectedTab: controller.selectedTab),
        ),
      ),
    );
  }

  LineChartData _chartData({
    required List<BalanceChartItem> chart,
    required BalanceTab selectedTab,
  }) {
    if (chart.isEmpty) return _emptyChart();

    final spots = _buildSpots(chart);
    final labels = _buildLabels(chart, selectedTab);
    final yAxis = _calculateYAxis(chart);
    final xAxis = _calculateXAxis(chart.length);

    return LineChartData(
      clipData: const FlClipData.all(),
      minX: xAxis.min,
      maxX: xAxis.max,
      minY: yAxis.min,
      maxY: yAxis.max,
      gridData: _gridData(),
      titlesData: _titlesData(
        labels: labels,
        yInterval: yAxis.step,
        selectedTab: selectedTab,
      ),
      borderData: FlBorderData(show: false),
      lineBarsData: [_line(spots)],
    );
  }

  // -------------------- Builders --------------------

  List<FlSpot> _buildSpots(List<BalanceChartItem> chart) =>
      List.generate(chart.length, (i) => FlSpot(i.toDouble(), chart[i].value));

  List<String> _buildLabels(List<BalanceChartItem> chart, BalanceTab tab) =>
      chart.map((e) => _formatLabel(e.label, tab)).toList();

  LineChartBarData _line(List<FlSpot> spots) {
    return LineChartBarData(
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
    );
  }

  // -------------------- Axis --------------------

  _YAxis _calculateYAxis(List<BalanceChartItem> chart) {
    final values = chart.map((e) => e.value).toList();
    final minValue = values.reduce(math.min);
    final maxValue = values.reduce(math.max);

    final range = maxValue - minValue == 0
        ? maxValue.abs()
        : maxValue - minValue;

    final step = _niceStep(range);

    final minY = math.max(0, (minValue / step).floorToDouble() * step);
    final maxY = (maxValue / step).ceilToDouble() * step;

    return _YAxis(min: minY.toDouble(), max: maxY.toDouble(), step: step);
  }

  _XAxis _calculateXAxis(int length) {
    final maxX = length > 1 ? length - 1.0 : 1.0;
    return _XAxis(min: -_xPadding, max: maxX + _xPadding);
  }

  // -------------------- Titles --------------------

  FlTitlesData _titlesData({
    required List<String> labels,
    required double yInterval,
    required BalanceTab selectedTab,
  }) {
    final maxLabels = selectedTab == BalanceTab.week ? 7 : 5;
    final step = (labels.length / maxLabels).ceil();

    return FlTitlesData(
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: yInterval,
          reservedSize: _yAxisReservedSize,
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
            final index = value.toInt();
            if (index < 0 || index >= labels.length) {
              return const SizedBox();
            }

            if (selectedTab != BalanceTab.week &&
                index % step != 0 &&
                index != labels.length - 1) {
              return const SizedBox();
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
    );
  }

  // -------------------- Helpers --------------------

  FlGridData _gridData() => FlGridData(
    show: true,
    getDrawingHorizontalLine: (_) =>
        FlLine(color: Colors.white10, strokeWidth: 1),
    getDrawingVerticalLine: (_) =>
        FlLine(color: Colors.white10, strokeWidth: 1),
  );

  LineChartData _emptyChart() => LineChartData(
    lineBarsData: const [],
    titlesData: const FlTitlesData(show: false),
    gridData: const FlGridData(show: false),
    borderData: FlBorderData(show: false),
  );

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

// -------------------- Models --------------------

class _YAxis {
  final double min;
  final double max;
  final double step;
  const _YAxis({required this.min, required this.max, required this.step});
}

class _XAxis {
  final double min;
  final double max;
  const _XAxis({required this.min, required this.max});
}
