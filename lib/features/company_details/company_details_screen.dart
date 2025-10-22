import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:para_job/features/company_details/company_details_controller.dart';
import 'package:para_job/features/company_details/widgets/active_job_list.dart';
import 'package:para_job/features/company_details/widgets/custom_container_company_details.dart';
import 'package:para_job/features/company_details/widgets/custom_gradient_progress.dart';
import 'package:para_job/features/company_details/widgets/reviews_list.dart';
import 'package:para_job/packages/api_client/src/enums/api_call_state_enum.dart'
    show ApiCallState;
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/curved_image.dart';
import 'package:para_job/packages/ui_components/error_screen.dart';

class CompanyDetailsScreen extends StatelessWidget {
  CompanyDetailsScreen({super.key});

  final combId = Get.arguments as int;
  late final controller = Get.put(CompanyDetailsController(combId));

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(CompanyDetailsController(2));

    return Scaffold(
      body: Center(
        child: Obx(() {
          switch (controller.companyDetailsCallState.value) {
            case ApiCallState.loading:
              return const Center(child: CircularProgressIndicator());

            case ApiCallState.success:
              final company = controller.companyData!.data;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    // Company Logo
                    CurvedHeaderWithGlow(
                      imageUrl: company.logo!,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.more_vert, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.wPct(5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: context.hPct(3)),

                          // Company Name
                          Text(
                            company.name ?? "Unknown Company",
                            style: TextStyle(
                              color: AppColors.pureWhite,
                              fontSize: context.wPct(5),
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          SizedBox(height: context.hPct(2)),

                          // Industry
                          Text(
                            company.industry ?? "-",
                            style: TextStyle(
                              color: AppColors.softWhite70,
                              fontSize: context.wPct(5),
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          SizedBox(height: context.hPct(4)),
                          // rate
                          Row(
                            children: [
                              Text(
                                company.averageRating.toString(),
                                style: TextStyle(
                                  color: AppColors.aquaTeal,
                                  fontSize: context.wPct(5),
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              context.wBox(2),

                              RatingBarIndicator(
                                rating: company.averageRating ?? 0.0,
                                itemBuilder: (context, index) =>
                                    Icon(Icons.star, color: AppColors.aquaTeal),
                                itemCount: 5,
                                itemSize: context.hPct(2),
                                direction: Axis.horizontal,
                              ),
                            ],
                          ),

                          SizedBox(height: context.hPct(4)),

                          // Stats
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: CustomContainerCompanyDetail(
                                  value:
                                      company.jobPostsCount?.toString() ?? "0",
                                  title: "JOBS",
                                ),
                              ),
                              context.wBox(2),
                              Expanded(
                                child: CustomContainerCompanyDetail(
                                  value:
                                      company.employeesCount?.toString() ?? "0",
                                  title: "Employees",
                                ),
                              ),
                              context.wBox(2),

                              Expanded(
                                child: CustomContainerCompanyDetail(
                                  value:
                                      company.reviewsCount?.toString() ?? "0",
                                  title: "REVIEWS ",
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: context.hPct(4)),
                          // positive reviews
                          Row(
                            //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Positive reviews",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: context.wPct(4),
                                ),
                                softWrap: true,
                                overflow: TextOverflow.visible,
                              ),
                              context.wBox(2),
                              Expanded(
                                child: GradientProgressBar(
                                  percentage:
                                      company.positiveReviewsPercentage ?? 0.0,
                                ),
                              ),
                              context.wBox(2),
                              Text(
                                "${company.positiveReviewsPercentage?.toString() ?? '0'}%",
                                style: TextStyle(
                                  color: AppColors.aquaTeal,
                                  fontWeight: FontWeight.w400,
                                  fontSize: context.wPct(3),
                                ),
                                softWrap: true,
                                overflow: TextOverflow.visible,
                              ),
                            ],
                          ),

                          SizedBox(height: context.hPct(4)),

                          // Active Jobs List

                          // Header Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Active Jobs",
                                style: TextStyle(
                                  fontSize: context.wPct(4.5),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  "See all",
                                  style: TextStyle(
                                    color: AppColors.softWhite70,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          context.hBox(2),

                          SizedBox(
                            height: context.hPct(23),
                            child: ActiveJobList(
                              jobs: company.activeJobs ?? [],
                            ),
                          ),

                          ReviewsList(reviews: company.latestReviews ?? []),
                          context.hBox(2),
                        ],
                      ),
                    ),
                  ],
                ),
              );

            case ApiCallState.failure:
              return Center(
                child: ErrorScreen(
                  onPressed: () {
                    controller.fetchCompDetails(combId);
                  },
                ),
              );
          }
        }),
      ),
    );
  }
}
