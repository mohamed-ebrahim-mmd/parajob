// Karim Toson || kareemtoson1@gmail.com || Tue Jan 06 2026 13:58:59

import 'package:flutter/material.dart';

class TransactionDummy {
  final IconData logo;
  final String title;
  final String company;
  final double amount;
  final String date;
  final bool isPositive;
  final VoidCallback? onTap;

  const TransactionDummy({
    required this.logo,
    required this.title,
    required this.company,
    required this.amount,
    required this.date,
    required this.isPositive,
    this.onTap,
  });
}
