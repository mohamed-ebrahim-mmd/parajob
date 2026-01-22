import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/profile/balance/balance_controller.dart';
import 'package:para_job/features/profile/balance/widgets/balance_chart.dart';
import 'package:para_job/features/profile/balance/widgets/balance_header.dart';
import 'package:para_job/features/profile/balance/widgets/balance_histor_section.dart';
import 'package:para_job/features/profile/balance/widgets/balance_time_frame_tabs.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/error_screen.dart';

class BalanceScreen extends StatelessWidget {
  BalanceScreen({super.key});

  final BalanceController _balanceController = Get.put(BalanceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          switch (_balanceController.balanceCallState.value) {
            case ApiCallState.loading:
              return const Center(child: CircularProgressIndicator());

            case ApiCallState.failure:
              return Center(
                child: ErrorScreen(
                  onPressed: _balanceController.fetchBalanceTransactions,
                ),
              );

            case ApiCallState.success:
              return Padding(
                padding: EdgeInsets.all(context.defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BalanceHeader(),
                    context.hBox(2.5),

                    BalanceTimeFrameTabs(),

                    context.hBox(2.5),

                    BalanceChart(),

                    context.hBox(2.5),

                    BalanceHistorySection(),
                  ],
                ),
              );
          }
        }),
      ),
    );
  }
}
