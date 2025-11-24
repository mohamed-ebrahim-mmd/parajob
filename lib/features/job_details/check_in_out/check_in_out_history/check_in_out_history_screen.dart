import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:para_job/features/job_details/check_in_out/check_in_out_history/widgets/check_in_out_history_card.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

import '../../../../packages/api_client/src/models/responses/check_in_out_history.dart';
import '../../../../packages/themeing/app_colors.dart';
import 'check_in_out_history_controller.dart';

class CheckInOutHistoryScreen extends StatelessWidget {
  CheckInOutHistoryScreen({super.key});

  final args = Get.arguments as Map<String, dynamic>;
  late final int jobId = args['jobId'] as int;
  late final controller = Get.put(CheckInOutHistoryController(jobId: jobId));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.charcoalBlack,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: context.hPct(7)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                context.hBox(2),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: AppColors.pureWhite,
                    size: context.wPct(5),
                  ),
                ),
                context.hBox(3),
                Text(
                  'attendance_history'.tr,
                  style: TextStyle(
                    color: AppColors.pureWhite,
                    fontSize: context.wPct(7),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 7),

                Text(
                  'check_past_shifts'.tr,
                  style: TextStyle(
                    color: AppColors.softWhite70,
                    fontSize: context.wPct(3.5),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                context.hBox(2),
                PagingListener(
                  controller: controller.pagingController,
                  builder: (context, state, fetchNextPage) {
                    return PagedListView<int, CheckInOutHistory>(
                      state: state,
                      fetchNextPage: fetchNextPage,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      builderDelegate:
                          PagedChildBuilderDelegate<CheckInOutHistory>(
                            noItemsFoundIndicatorBuilder: (_) => Center(
                              child: Text(
                                'no_data_found'.tr,
                                style: TextStyle(fontSize: context.wPct(4)),
                              ),
                            ),
                            itemBuilder: (context, item, index) => Padding(
                              padding: EdgeInsets.only(bottom: context.hPct(2)),
                              child: CheckInOutHistoryCard(
                                checkInOutHistory: item,
                                workedHours: controller.calculateWorkedHours(
                                  item.checkInAt,
                                  item.checkOutAt,
                                ),
                              ),
                            ),
                          ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
