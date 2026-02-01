import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:para_job/packages/api_client/src/models/responses/balance_transactions_response.dart';
import 'package:para_job/packages/themeing/app_colors.dart';

LineChartData chartData({required List<BalanceChartItem> chart}) {
  if (chart.isEmpty) {
    return LineChartData(
      gridData: const FlGridData(show: false),
      titlesData: const FlTitlesData(show: false),
      borderData: FlBorderData(show: false),
      lineBarsData: const [],
    );
  }

  final spots = List.generate(
    chart.length,
    (i) => FlSpot(i.toDouble(), chart[i].value),
  );

  // Calculate min value
  final values = chart.map((e) => e.value).toList();
  final minValue = values.reduce((a, b) => a < b ? a : b);

  return LineChartData(
    minY: minValue,

    gridData: const FlGridData(show: true),
    borderData: FlBorderData(show: false),

    titlesData: FlTitlesData(
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 56,
          getTitlesWidget: (value, meta) => Text(
            'EGP ${value.toInt()}',
            style: const TextStyle(color: Colors.white54, fontSize: 12),
          ),
        ),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: 1,
          getTitlesWidget: (value, meta) {
            final index = value.toInt();
            if (index < 0 || index >= chart.length) {
              return const SizedBox();
            }

            return Padding(
              padding: const EdgeInsets.only(top: 8, right: 8),
              child: Text(
                chart[index].label,

                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
      ),
    ),

    lineBarsData: [
      LineChartBarData(
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
      ),
    ],
  );
}
