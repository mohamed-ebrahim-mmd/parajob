import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/employer/employer_controller.dart';
import 'package:para_job/features/employer/widgets/active_jobs_list.dart';
import 'package:para_job/features/employer/widgets/employer_list_header.dart';
import 'package:para_job/features/employer/widgets/employer_stat_box.dart';
import 'package:para_job/features/employer/widgets/employer_submit_review.dart';
import 'package:para_job/features/employer/widgets/latest_reviews_list.dart';
import 'package:para_job/features/job_details/complaint/widgets/company_complaint_bottom_sheet.dart';
import 'package:para_job/packages/api_client/src/enums/api_call_state_enum.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/app_star_rating.dart';
import 'package:para_job/packages/ui_components/curved_image.dart';
import 'package:para_job/packages/ui_components/error_screen.dart';

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
              return Center(child: Text('no_data'.tr));
            }
            log("🟢 ${company.toString()}");

            return SingleChildScrollView(
              padding: EdgeInsets.only(bottom: context.hPct(7)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CurvedHeaderWithGlow(
                    imageUrl: company.logo ?? "",
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.arrow_back_ios_new),
                        ),
                        IconButton(
                          onPressed: () {
                            showCompanyComplaintBottomSheet(
                              companyId: company.id!,
                              companyName: company.name!,
                              companyIsSubmitComplaint:
                                  company.isSubmitComplaint ?? false,
                            );
                          },
                          icon: const Icon(
                            Icons.more_vert,
                            color: AppColors.pureWhite,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.defaultPadding,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        context.hBox(.5),
                        Text(
                          company.name ?? "",
                          style: TextStyle(
                            fontSize: context.wPct(6),
                            fontWeight: FontWeight.w700,
                            color: AppColors.pureWhite,
                          ),
                        ),
                        context.hBox(.5),
                        Text(
                          company.industry ?? "",
                          style: TextStyle(
                            fontSize: context.wPct(3.5),
                            fontWeight: FontWeight.w400,
                            color: AppColors.white50,
                          ),
                        ),
                        context.hBox(.5),

                        Row(
                          children: [
                            Text(
                              company.averageRating != null
                                  ? company.averageRating!.toStringAsFixed(1)
                                  : "0.0",
                              style: TextStyle(
                                fontSize: context.wPct(5),
                                fontWeight: FontWeight.w800,
                                color: AppColors.aquaTeal,
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
                              title: 'jobs'.tr,
                              value: "${company.jobPostsCount ?? 0}+",
                            ),
                            context.wBox(1),
                            EmployerStatBox(
                              title: 'employees'.tr,
                              value: "${company.employeesCount ?? 0}+",
                            ),
                            context.wBox(1),
                            EmployerStatBox(
                              title: 'reviews'.tr,
                              value: "${company.reviewsCount ?? 0}+",
                            ),
                          ],
                        ),
                        context.hBox(2),

                        Center(
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                'positive_reviews'.tr,
                                style: TextStyle(
                                  fontSize: context.wPct(3.5),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              context.wBox(3),
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
                              context.wBox(3),
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

                        context.hBox(3),
                        EmployerListHeader(
                          title: 'active_jobs'.tr,
                          onViewAll: controller.goToActiveJobs,
                          showViewAllButton:
                              company.activeJobs != null &&
                              company.activeJobs!.isNotEmpty,
                        ),
                        context.hBox(2),
                        ActiveJobsList(company: company),

                        context.hBox(2),
                        EmployerListHeader(
                          title: 'reviews'.tr,
                          onViewAll: controller.goToEmployerReviews,
                          showViewAllButton:
                              company.latestReviews != null &&
                              company.latestReviews!.isNotEmpty,
                        ),
                        context.hBox(2),
                        LatestReviewsList(company: company),
                        context.hBox(2),
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
                                  'already_shared_feedback'.tr,
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
