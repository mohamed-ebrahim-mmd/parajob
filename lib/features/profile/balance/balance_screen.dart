// Karim Toson || kareemtoson1@gmail.com || 5/1/2026 10:50AM

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BalanceScreen extends StatelessWidget {
  const BalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('balance'.tr),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(child: Text('Balance Screen')),
    );
  }
}
