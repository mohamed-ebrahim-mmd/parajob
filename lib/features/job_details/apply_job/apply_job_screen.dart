import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/job_details/apply_job/widgets/info_row.dart';
import 'package:para_job/features/job_details/job_details_controller.dart';
import 'package:para_job/features/job_details/widgets/job_content.dart'
    show JobContent;
import 'package:para_job/features/job_details/widgets/job_skill_item.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/curved_image.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

import '../../../res/app_asset_paths.dart';

class ApplyJobScreen extends StatelessWidget {
  final jobId = Get.arguments as int;
  late final controller = Get.find<JobDetailsController>(tag: jobId.toString());
  late final jobDetails = controller.jobData!.data;
  final user = Get.find<UserController>();

  ApplyJobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black80,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CurvedHeaderWithGlow(
              imageUrl: jobDetails.logo,
              child: JobContent(
                jobDetails: jobDetails,
                onCompanyTap: () {
                  Get.toNamed(
                    "${Routes.jobDetails}${Routes.employer}",
                    arguments: {'id': jobDetails.company.id},
                  );
                },
              ),
            ),
            context.hBox(2),
            Container(
              padding: EdgeInsets.symmetric(horizontal: context.defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'review_application'.tr,
                    style: TextStyle(
                      color: AppColors.pureWhite,
                      fontSize: context.wPct(5.5),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  context.hBox(2),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(context.defaultPadding * 1.5),
                    decoration: BoxDecoration(
                      color: AppColors.charcoalBlack,
                      borderRadius: BorderRadius.circular(context.wPct(3)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InfoRow(
                          label: 'full_name'.tr,
                          value: user.user!.name.toString(),
                        ),
                        InfoRow(
                          label: 'phone'.tr,
                          value: user.user!.phoneNumber.toString(),
                        ),
                        InfoRow(
                          label: 'email'.tr,
                          value: user.user!.email.toString(),
                        ),
                        if (user.user?.educationStatus != null)
                          InfoRow(
                            label: 'status'.tr,
                            value: user.user!.educationStatus.toString(),
                          ),
                        InfoRow(
                          label: 'national_id'.tr,
                          value: user.user!.nationalId.toString(),
                        ),
                        context.hBox(1),
                        Divider(color: AppColors.line, height: context.hPct(1)),
                        context.hBox(1),
                        Text(
                          'skills'.tr,
                          style: TextStyle(
                            color: AppColors.white60,
                            fontSize: context.wPct(4),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        context.hBox(1),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: user.user!.skills!
                              .map((skill) => JobSkillItem(skill: skill))
                              .toList(),
                        ),
                        context.hBox(1),
                        if (user.user?.cv != null &&
                            user.user?.cvUploadedDate != null) ...[
                          const Divider(color: AppColors.line),
                          context.hBox(1),
                          Text(
                            'document'.tr,
                            style: TextStyle(
                              color: AppColors.white60,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          context.hBox(1),
                          Container(
                            padding: EdgeInsets.all(context.wPct(3)),
                            decoration: BoxDecoration(
                              color: const Color(0xFF2A2A2A),
                              borderRadius: BorderRadius.circular(
                                context.wPct(2),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: context.wPct(10),
                                  height: context.wPct(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      context.wPct(2),
                                    ),
                                    color: AppColors.white5,
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  padding: EdgeInsets.all(context.wPct(1)),
                                  child: Image.asset(
                                    AppAssetPaths.pdfIcon,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                context.wBox(3),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        user.user!.cv
                                            .toString()
                                            .split('/')
                                            .last,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        '${'uploaded'.tr} ${user.user?.cvUploadedDate ?? "-"}',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: context.wPct(3),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          context.hBox(.5),
                        ],
                      ],
                    ),
                  ),
                  context.hBox(2),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      minimumSize: Size(context.w, context.hPct(6.5)),
                      // width, height
                    ),
                    onPressed: () async {
                      controller.applyJob(context, jobDetails.id);
                    },
                    child: Text(
                      'apply_job_button'.tr,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  context.hBox(4),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
