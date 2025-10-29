/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-15 2:00 PM
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:para_job/features/home/search_job/search_job_controller.dart';
import 'package:para_job/features/home/search_job/widgets/show_filter_bottom_sheet.dart';
import 'package:para_job/packages/api_client/src/enums/api_call_state_enum.dart'
    show ApiCallState;
import 'package:para_job/packages/api_client/src/models/responses/job.dart'
    show Job;
import 'package:para_job/packages/route_manager/controller/routes.dart'
    show Routes;
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/error_screen.dart';
import 'package:para_job/packages/ui_components/job_card.dart' show JobCard;

class SearchJobScreen extends StatelessWidget {
  final controller = Get.put(SearchJobController());
  SearchJobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColors.charcoalBlack,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.wPct(5)),
        child: Obx(() {
          switch (controller.searchDataCallState.value) {
            case ApiCallState.loading:
              return const Center(child: CircularProgressIndicator());

            case ApiCallState.success:
              return Column(
                children: [
                  context.hBox(2),
                  TextField(
                    controller: controller.titleController,
                    decoration: InputDecoration(
                      hintText: 'Search jobs, companies..',
                      prefixIcon: IconButton(
                        onPressed: () {
                          controller.pagingController.refresh();
                        },
                        icon: const Icon(Icons.search),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () async {
                          await showFilterBottomSheet(context, controller);
                        },
                        icon: const Icon(Icons.tune),
                      ),
                      filled: false,
                    ),
                  ),
                  context.hBox(2),
                  Expanded(
                    child: PagingListener<int, Job>(
                      controller: controller.pagingController,
                      builder: (context, state, fetchNextPage) =>
                          PagedListView<int, Job>(
                            state: state,
                            fetchNextPage: fetchNextPage,
                            builderDelegate: PagedChildBuilderDelegate(
                              itemBuilder: (context, item, index) => Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: context.hPct(1),
                                ),
                                child: JobCard(
                                  job: item,
                                  onTap: () {
                                    Get.toNamed(
                                      Routes.jobDetails,
                                      arguments: item.id,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                    ),
                  ),
                ],
              );

            case ApiCallState.failure:
              return Center(
                child: ErrorScreen(
                  onPressed: () {
                    controller.initializeSearchData();
                  },
                ),
              );
          }
        }),
      ), // empty screen
    );
  }
}
