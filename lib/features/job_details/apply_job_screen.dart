import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:para_job/features/job_details/job_details_controller.dart';
import 'package:para_job/features/job_details/widgets/job_content.dart'
    show JobContent;
import 'package:para_job/features/job_details/widgets/job_skill_item.dart';
import 'package:para_job/packages/api_client/src/enums/api_call_state_enum.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/curved_image.dart';
import 'package:para_job/packages/ui_components/error_screen.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

import '../../res/app_asset_paths.dart';

class ApplyJobScreen extends StatelessWidget {
  final jobId = Get.arguments as int;
  late final controller = Get.find<JobDetailsController>(tag: jobId.toString());
  final user = Get.find<UserController>();
  ApplyJobScreen({super.key});

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.white60,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.pureWhite,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black80,
      body: Obx(() {
        switch (controller.jobDetailsCallState.value) {
          case ApiCallState.loading:
            return const Center(child: CircularProgressIndicator());
          case ApiCallState.success:
            final jobDetails = controller.jobData!.data;

            return SingleChildScrollView(
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
                    padding: const EdgeInsets.all(16),
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
                        const SizedBox(height: 16),

                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppColors.charcoalBlack,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildInfoRow(
                                'Full name',
                                user.user!.name.toString(),
                              ),
                              _buildInfoRow(
                                'Phone',
                                user.user!.phoneNumber.toString(),
                              ),
                              _buildInfoRow(
                                'Email',
                                user.user!.email.toString(),
                              ),
                              if (user.user?.educationStatus != null)
                                _buildInfoRow(
                                  'Status',
                                  user.user!.educationStatus.toString(),
                                ),
                              _buildInfoRow(
                                'National ID',
                                user.user!.nationalId.toString(),
                              ),
                              const Divider(color: AppColors.line, height: 30),

                              Text(
                                'Skills',
                                style: TextStyle(
                                  color: AppColors.white60,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: user.user!.skills!
                                    .map((skill) => JobSkillItem(skill: skill))
                                    .toList(),
                              ),
                              const SizedBox(height: 16),
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
                                const SizedBox(height: 8),

                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF2A2A2A),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 44,
                                        height: 44,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          color: AppColors.white5,
                                        ),
                                        clipBehavior: Clip.antiAlias,
                                        padding: const EdgeInsets.all(8),
                                        child: Image.asset(
                                          AppAssetPaths.pdfIcon,
                                          fit: BoxFit.contain,
                                        ),
                                      ),

                                      const SizedBox(width: 12),
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
                                              'Uploaded ${DateFormat('dd/MM/yyyy').format(user.user!.cvUploadedDate!)}',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 10,
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

                        const SizedBox(height: 24),
                        FilledButton(
                          onPressed: () async {
                            controller.applyJob(context, jobDetails.id);
                          },
                          child: const Text(
                            'Yes, Apply for this job',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),
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
                  controller.fetchJobDetails(jobId);
                },
              ),
            );
        }
      }),
    );
  }
}
