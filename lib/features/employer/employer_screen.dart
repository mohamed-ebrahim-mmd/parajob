import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/employer/employer_controller.dart';
import 'package:para_job/features/employer/widgets/active_jobs_list.dart';
import 'package:para_job/features/employer/widgets/employer_hero_section.dart';
import 'package:para_job/features/employer/widgets/employer_list_header.dart';
import 'package:para_job/features/employer/widgets/employer_stat_box.dart';
import 'package:para_job/features/employer/widgets/employer_submit_review.dart';
import 'package:para_job/features/employer/widgets/latest_reviews_list.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

import '../../packages/api_client/src/enums/api_call_state_enum.dart';
import '../../packages/ui_components/app_star_rating.dart';
import '../../packages/ui_components/error_screen.dart';

class EmployerScreen extends StatelessWidget {
  EmployerScreen({super.key});
  final int id = Get.arguments['id'];
  late final controller = Get.put(EmployerController(id));

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Obx(() {
        switch (controller.companyCallState.value) {
          case ApiCallState.loading:
            return const Center(child: CircularProgressIndicator());
          case ApiCallState.failure:
            return Center(
              child: ErrorScreen(
                onPressed: () {
                  controller.fetchCompany();
                },
              ),
            );
          case ApiCallState.success:
            final company = controller.companyData;
            if (company == null) {
              return const Center(child: Text("No data"));
            }

            return SingleChildScrollView(
              padding: EdgeInsets.only(bottom: context.hPct(7)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EmployerHeroSection(imageUrl: company.logo),
                  Padding(
                    padding: EdgeInsets.all(context.wPct(4)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          company.name ?? "",
                          style: TextStyle(
                            fontSize: context.wPct(6),
                            fontWeight: FontWeight.w700,
                            color: AppColors.pureWhite,
                          ),
                        ),
                        context.hBox(1),
                        Text(
                          company.industry ?? "",
                          style: TextStyle(
                            fontSize: context.wPct(3.5),
                            fontWeight: FontWeight.w400,
                            color: AppColors.white50,
                          ),
                        ),
                        context.hBox(1),

                        Row(
                          children: [
                            Text(
                              company.averageRating != null
                                  ? company.averageRating!.toStringAsFixed(1)
                                  : "0.0",
                              style: TextStyle(
                                fontSize: context.wPct(5),
                                fontWeight: FontWeight.w800,
                                color: Colors.teal,
                              ),
                            ),
                            context.wBox(1.5),
                            AppStarRating(
                              rating: company.averageRating ?? 0,
                              size: context.wPct(1),
                            ),
                          ],
                        ),
                        context.hBox(2),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            EmployerStatBox(
                              title: "JOBS",
                              value: "${company.jobPostsCount ?? 0}+",
                            ),
                            EmployerStatBox(
                              title: "Employees",
                              value: "${company.employeesCount ?? 0}+",
                            ),
                            EmployerStatBox(
                              title: "Reviews",
                              value: "${company.reviewsCount ?? 0}+",
                            ),
                          ],
                        ),
                        context.hBox(3),

                        Center(
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            // mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Positive Reviews",
                                style: TextStyle(
                                  fontSize: context.wPct(3.5),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(width: context.wPct(3)),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  context.wPct(10),
                                ),
                                child: Container(
                                  width: context.wPct(25),
                                  height: context.hPct(0.8),
                                  color: AppColors.lightGray,
                                  child: FractionallySizedBox(
                                    widthFactor:
                                        (company.positiveReviewsPercentage ??
                                            0) /
                                        100.0,
                                    child: Container(color: AppColors.aquaTeal),
                                  ),
                                ),
                              ),
                              SizedBox(width: context.wPct(3)),
                              Text(
                                "${company.positiveReviewsPercentage?.toStringAsFixed(0) ?? 0}%",
                                style: TextStyle(
                                  fontSize: context.wPct(2.5),
                                  color: AppColors.aquaTeal,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),

                        context.hBox(4),

                        EmployerListHeader(
                          title: "Active Jobs",
                          onViewAll: () {},
                        ),

                        ActiveJobsList(company: company),
                        context.hBox(4),

                        EmployerListHeader(
                          title: "Reviews",
                          onViewAll: () {
                            Get.toNamed(
                              Routes.employerReviews,
                              arguments: {'id': company.id},
                            );
                          },
                        ),
                        LatestReviewsList(company: company),

                        if (company.isSubmitReview == true)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.check_circle_outline,
                                color: AppColors.white40,
                                size: context.hPct(2.5),
                              ),
                              context.wBox(2),
                              Flexible(
                                child: Text(
                                  "You’ve already shared your thoughts about this employer. Thank you for your feedback!",
                                  style: TextStyle(
                                    color: AppColors.softWhite70,
                                    fontWeight: FontWeight.w500,
                                    fontSize: context.wPct(3.5),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          )
                        else
                          EmployerSubmitReview(),
                      ],
                    ),
                  ),
                ],
              ),
            );
        }
      }),
    );
  }
}
