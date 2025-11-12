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
            context.hBox(context.wPct(0.5)),
            Container(
              padding: EdgeInsets.all(context.wPct(5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    'Review Application',
                    style: TextStyle(
                      color: AppColors.pureWhite,
                      fontSize: context.wPct(6),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: context.hPct(2)),

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(context.wPct(5)),
                    decoration: BoxDecoration(
                      color: AppColors.charcoalBlack,
                      borderRadius: BorderRadius.circular(context.wPct(2)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InfoRow(
                          label: 'Full name',
                          value: user.user!.name.toString(),
                        ),
                        InfoRow(
                          label: 'Phone',
                          value: user.user!.phoneNumber.toString(),
                        ),
                        InfoRow(
                          label: 'Email',
                          value: user.user!.email.toString(),
                        ),

                        if (user.user?.educationStatus != null)
                          InfoRow(
                            label: 'Status',
                            value: user.user!.educationStatus.toString(),
                          ),

                        InfoRow(
                          label: 'National ID',
                          value: user.user!.nationalId.toString(),
                        ),

                        Divider(color: AppColors.line, height: context.hPct(1)),

                        Text(
                          'Skills',
                          style: TextStyle(
                            color: AppColors.white60,
                            fontSize: context.wPct(4),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: context.hPct(0.5)),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: user.user!.skills!
                              .map((skill) => JobSkillItem(skill: skill))
                              .toList(),
                        ),
                        SizedBox(height: context.hPct(2)),
                        if (user.user?.cv != null &&
                            user.user?.cvUploadedDate != null) ...[
                          const Divider(color: AppColors.line),
                          const SizedBox(height: 16),
                          Text(
                            'Document',
                            style: TextStyle(
                              color: AppColors.white60,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: context.hPct(1)),

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

                                SizedBox(width: context.wPct(3)),
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
                                        'Uploaded ${user.user?.cvUploadedDate ?? "-"}',
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
                        ],
                      ],
                    ),
                  ),

                  SizedBox(height: context.hPct(2)),
                  FilledButton(
                    onPressed: () async {
                      controller.applyJob(context, jobDetails.id);
                    },
                    child: Text(
                      'Yes, Apply for this job',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  SizedBox(height: context.hPct(4)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
