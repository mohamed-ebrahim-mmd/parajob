import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/packages/api_client/src/service/api_call_state_enum.dart';
import 'package:para_job/features/company_details/company_details_controller.dart';
import 'package:para_job/packages/ui_components/error_screen.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class CompanyDetailsScreen extends StatelessWidget {
  const CompanyDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CompanyDetailsController(1));

    return Scaffold(
      body: Center(
        child: Obx(() {
          switch (controller.companyDetailsCallState.value) {
            case ApiCallState.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );

            case ApiCallState.success:
              final company = controller.companyData!.data;
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(context.wPct(5)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Company Logo
                      if (company.logo != null)
                        CircleAvatar(
                          radius: context.wPct(20),
                          backgroundImage: NetworkImage(company.logo!),
                        ),

                      SizedBox(height: context.hPct(3)),

                      // Company Name
                      Text(
                        company.name ?? "Unknown Company",
                        style: TextStyle(
                          fontSize: context.wPct(6),
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: context.hPct(2)),

                      // Industry
                      Text(
                        "Industry: ${company.industry ?? "-"}",
                        style: TextStyle(
                          fontSize: context.wPct(4),
                          color: Colors.grey[700],
                        ),
                      ),

                      SizedBox(height: context.hPct(4)),

                      // Stats
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _infoItem("Jobs", company.jobPostsCount?.toString() ?? "0"),
                          _infoItem("Employees", company.employeesCount?.toString() ?? "0"),
                          _infoItem("Reviews", company.reviewsCount?.toString() ?? "0"),
                        ],
                      ),

                      SizedBox(height: context.hPct(4)),

                      // Active Jobs List
                      if (company.activeJobs?.isNotEmpty ?? false) ...[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Active Jobs",
                            style: TextStyle(
                              fontSize: context.wPct(5),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: context.hPct(2)),
                        Column(
                          children: company.activeJobs!
                              .map(
                                (job) => Card(
                                  margin: EdgeInsets.symmetric(vertical: 8),
                                  child: ListTile(
                                    title: Text(job.title ?? ""),
                                    subtitle: Text(job.description ?? ""),
                                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ],
                  ),
                ),
              );

            case ApiCallState.failure:
              return ErrorScreen(
                height: context.hPct(60),
                onPressed: () {
                  controller.fetchCompDetails(1);
                },
              );
          }
        }),
      ),
    );
  }

  Widget _infoItem(String title, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
