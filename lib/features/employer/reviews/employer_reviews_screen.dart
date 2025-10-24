import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:para_job/features/employer/reviews/employer_reviews_controller.dart';
import '../../../packages/api_client/src/models/responses/review.dart';
import '../../../packages/themeing/app_colors.dart';
import '../../../packages/themeing/media_query_values.dart';
import '../../../packages/ui_components/app_star_rating.dart';
import '../../review/widgets/review_card.dart';

class EmployerReviewsScreen extends StatefulWidget {
  EmployerReviewsScreen({super.key});
  final int id = Get.arguments['id'];

  @override
  State<EmployerReviewsScreen> createState() => _EmployerReviewsScreenState();
}

class _EmployerReviewsScreenState extends State<EmployerReviewsScreen> {
  late EmployerReviewsController controller;

  late final pagingController = PagingController<int, Review>(
    getNextPageKey: (state) => state.lastPageIsEmpty ? null : state.nextIntPageKey,
    fetchPage: (pageKey) {
      return controller.fetchCompanyReviews(companyId: widget.id, page: pageKey);
    },
  );

  @override
  void initState() {
    super.initState();
    controller =
        Get.find<EmployerReviewsController>();
  }
  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

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
                SizedBox(height: context.hPct(2)),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: AppColors.pureWhite,
                    size: context.wPct(5),
                  ),
                ),
                SizedBox(height: context.hPct(1)),
                Text(
                  'Reviews',
                  style: TextStyle(
                    fontSize: context.wPct(6),
                    fontWeight: FontWeight.w600,
                    color: AppColors.pureWhite,
                  ),
                ),
                SizedBox(height: context.hPct(2)),
                Obx(
                      () => Row(
                    children: [
                      Text(
                        controller.averageRating.value.toStringAsFixed(1),
                        style: TextStyle(
                          fontSize: context.wPct(5),
                          fontWeight: FontWeight.w800,
                          color: Colors.teal,
                        ),
                      ),
                      SizedBox(width: context.wPct(1.5)),
                      AppStarRating(
                        rating: controller.averageRating.value,
                        size: context.wPct(1),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: context.hPct(2)),
                PagingListener(
                  controller: pagingController,
                  builder: (context, state, fetchNextPage) {
                    return PagedListView<int, Review>(
                      state: state,
                      fetchNextPage: fetchNextPage,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      builderDelegate: PagedChildBuilderDelegate<Review>(
                        firstPageProgressIndicatorBuilder: (_) => Center(
                          child: SizedBox(
                            width: context.wPct(8),
                            height: context.wPct(8),
                            child: const CircularProgressIndicator(),
                          ),
                        ),
                        newPageProgressIndicatorBuilder: (_) => Center(
                          child: SizedBox(
                            width: context.wPct(8),
                            height: context.wPct(8),
                            child: const CircularProgressIndicator(),
                          ),
                        ),
                        noItemsFoundIndicatorBuilder: (_) => Center(
                          child: Text(
                            "No reviews found",
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
