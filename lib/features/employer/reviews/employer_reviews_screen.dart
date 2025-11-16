import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:para_job/features/employer/reviews/employer_reviews_controller.dart';
import 'package:para_job/features/employer/reviews/widgets/review_card.dart';

import '../../../packages/api_client/src/models/responses/review.dart';
import '../../../packages/themeing/app_colors.dart';
import '../../../packages/themeing/media_query_values.dart';
import '../../../packages/ui_components/app_star_rating.dart';

class EmployerReviewsScreen extends StatelessWidget {
  EmployerReviewsScreen({super.key});

  final int id = Get.arguments['id'];
  late final controller = Get.put(EmployerReviewsController(id));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.charcoalBlack,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: context.hPct(7)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.wPct(5)),
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
                context.hBox(1),
                Text(
                  'reviews'.tr,
                  style: TextStyle(
                    fontSize: context.wPct(6),
                    fontWeight: FontWeight.w600,
                    color: AppColors.pureWhite,
                  ),
                ),
                context.hBox(2),
                Obx(
                  () => Visibility(
                    visible:
                        controller.pagingController.status !=
                        PagingStatus.loadingFirstPage,
                    child: Row(
                      children: [
                        Text(
                          controller.averageRating.value.toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: context.wPct(5),
                            fontWeight: FontWeight.w800,
                            color: Colors.teal,
                          ),
                        ),
                        context.wBox(1.5),
                        AppStarRating(
                          rating: controller.averageRating.value,
                          size: context.wPct(1),
                        ),
                      ],
                    ),
                  ),
                ),
                context.hBox(2),
                PagingListener(
                  controller: controller.pagingController,
                  builder: (context, state, fetchNextPage) {
                    return PagedListView<int, Review>(
                      state: state,
                      fetchNextPage: fetchNextPage,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      builderDelegate: PagedChildBuilderDelegate<Review>(
                        noItemsFoundIndicatorBuilder: (_) => Center(
                          child: Text(
                            'no_reviews_found'.tr,
                            style: TextStyle(fontSize: context.wPct(4)),
                          ),
                        ),
                        itemBuilder: (context, item, index) => Padding(
                          padding: EdgeInsets.only(bottom: context.hPct(2)),
                          child: ReviewCard(review: item),
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
