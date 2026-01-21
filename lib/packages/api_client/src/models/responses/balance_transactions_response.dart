import 'package:para_job/packages/api_client/src/models/responses/base_response.dart';
import 'package:para_job/packages/api_client/src/models/responses/response_details.dart';

class BalanceTransactionsResponse extends BaseResponse {
  final BalanceTransactionsData? data;

  BalanceTransactionsResponse({
    required super.isSuccess,
    super.details,
    this.data,
  });

  factory BalanceTransactionsResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return BalanceTransactionsResponse(isSuccess: false);

    return BalanceTransactionsResponse(
      isSuccess: json['is_success'] ?? false,
      details: json['details'] != null
          ? ResponseDetails.fromJson(json['details'])
          : null,
      data: json['data'] != null
          ? BalanceTransactionsData.fromJson(json['data'])
          : null,
    );
  }
}

class BalanceTransactionsData {
  final BalanceSummary summary;
  final List<BalanceChartItem> chart;
  final Map<String, List<BalanceTransaction>> transactions;

  BalanceTransactionsData({
    required this.summary,
    required this.chart,
    required this.transactions,
  });

  factory BalanceTransactionsData.fromJson(Map<String, dynamic> json) {
    final transactionsMap = <String, List<BalanceTransaction>>{};
    if (json['transactions'] != null) {
      (json['transactions'] as Map<String, dynamic>).forEach((key, value) {
        transactionsMap[key] = (value as List)
            .map((e) => BalanceTransaction.fromJson(e))
            .toList();
      });
    }

    return BalanceTransactionsData(
      summary: BalanceSummary.fromJson(json['summary']),
      chart:
          (json['chart'] as List?)
              ?.map((e) => BalanceChartItem.fromJson(e))
              .toList() ??
          [],
      transactions: transactionsMap,
    );
  }
}

class BalanceSummary {
  final String currency;
  final double totalBalance;

  BalanceSummary({required this.currency, required this.totalBalance});

  factory BalanceSummary.fromJson(Map<String, dynamic> json) {
    return BalanceSummary(
      currency: json['currency'] ?? '',
      totalBalance: (json['total_balance'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class BalanceChartItem {
  final String label;
  final double value;

  BalanceChartItem({required this.label, required this.value});

  factory BalanceChartItem.fromJson(Map<String, dynamic> json) {
    return BalanceChartItem(
      label: json['label'] ?? '',
      value: (json['value'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class BalanceTransaction {
  final int id;
  final double amount;
  final String occurredAt;
  final String type;
  final String reason;
  final String jobTitle;
  final BalanceCompany company;

  BalanceTransaction({
    required this.id,
    required this.amount,
    required this.occurredAt,
    required this.type,
    required this.reason,
    required this.jobTitle,
    required this.company,
  });

  factory BalanceTransaction.fromJson(Map<String, dynamic> json) {
    return BalanceTransaction(
      id: json['id'] ?? 0,
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      occurredAt: json['occurred_at'] ?? '',
      type: json['type'] ?? '',
      reason: json['reason'] ?? '',
      jobTitle: json['job_title'] ?? '',
      company: BalanceCompany.fromJson(json['company'] ?? {}),
    );
  }
}

class BalanceCompany {
  final String name;
  final String logo;

  BalanceCompany({required this.name, required this.logo});

  factory BalanceCompany.fromJson(Map<String, dynamic> json) {
    return BalanceCompany(name: json['name'] ?? '', logo: json['logo'] ?? '');
  }
}
