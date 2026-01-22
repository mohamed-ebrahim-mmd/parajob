import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:para_job/packages/api_client/src/models/responses/balance_transactions_response.dart';

class BalanceChart extends StatelessWidget {
  const BalanceChart({super.key, required this.chart, required this.currency});

  final List<BalanceChartItem> chart;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0E141B),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          LineChart(mainData()),
          _buildArrow(Icons.chevron_left, Alignment.centerLeft),
          _buildArrow(Icons.chevron_right, Alignment.centerRight),
        ],
      ),
    );
  }

  Widget _buildArrow(IconData icon, Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Icon(icon, color: Colors.white54, size: 28),
    );
  }

  LineChartData mainData() {
    if (chart.isEmpty) {
      return LineChartData(
        lineBarsData: const [],
        titlesData: const FlTitlesData(show: false),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
      );
    }

    final spots = List<FlSpot>.generate(
      chart.length,
      (i) => FlSpot(i.toDouble(), chart[i].value),
    );

    final labels = chart.map((e) => _formatLabel(e.label)).toList();

    final values = chart.map((e) => e.value).toList();
    final minValue = values.reduce((a, b) => a < b ? a : b);
    final maxValue = values.reduce((a, b) => a > b ? a : b);

    final range = (maxValue - minValue).abs();
    final yPadding = range == 0 ? 50.0 : (range * 0.2);
    final minY = (minValue < 0 ? minValue : 0) - yPadding;
    final maxY = (maxValue > 0 ? maxValue : 0) + yPadding;
    final interval = _niceInterval(maxY - minY);

    final maxX = (chart.length - 1).toDouble();
    final safeMaxX = maxX == 0 ? 1.0 : maxX;
    final bottomEvery = ((chart.length / 5).ceil())
        .clamp(1, chart.length)
        .toInt();

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
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
            getTitlesWidget: (value, _) {
              return Text(
                '$currency ${value.toStringAsFixed(0)}',
                style: const TextStyle(color: Colors.white54, fontSize: 12),
              );
            },
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: (value, _) {
              final index = value.toInt();
              if (index < 0 || index >= labels.length) return const SizedBox();

              final shouldShow =
                  index % bottomEvery == 0 || index == labels.length - 1;
              if (shouldShow) {
                return Text(
                  labels[index],
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: safeMaxX,
      minY: minY,
      maxY: maxY,
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          barWidth: 3,
          color: const Color(0xFF2FE3C2),
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                const Color(0xFF2FE3C2).withValues(alpha: 0.3),
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

  String _formatLabel(String raw) {
    final date = DateTime.tryParse(raw);
    if (date == null) return raw;
    return DateFormat('d MMM').format(date);
  }

  double _niceInterval(double range) {
    if (range <= 0) return 1;

    final raw = range / 3;
    final magnitude = _pow10(raw);
    final normalized = raw / magnitude;

    final step = normalized >= 5
        ? 10
        : normalized >= 2
        ? 5
        : normalized >= 1
        ? 2
        : 1;

    return step * magnitude;
  }

  double _pow10(double value) {
    var v = value;
    var pow = 1.0;
    while (v >= 10) {
      v /= 10;
      pow *= 10;
    }
    while (v > 0 && v < 1) {
      v *= 10;
      pow /= 10;
    }
    return pow;
  }
}
