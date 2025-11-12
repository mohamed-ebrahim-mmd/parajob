import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import '../home/home_controller.dart';
import 'job_details_controller.dart';

class JobApplicationSuccessScreen extends StatelessWidget {
  JobApplicationSuccessScreen({super.key});
  final jobId = Get.arguments as int;
  late final controller = Get.find<JobDetailsController>(tag: jobId.toString());

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          controller.fetchJobDetails(jobId);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.charcoalBlack,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.wPct(8)),
              child: Container(
                padding: EdgeInsets.all(context.wPct(6)),
                decoration: BoxDecoration(
                  color: AppColors.midnightBlue,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Congrats! your application for this job is now being considered. 🎉",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: context.wPct(5),
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    context.hBox(3),
                    FilledButton(
                      onPressed: () {
                        Get.put(HomeController());
                        Get.offAllNamed(Routes.mainNavigator);
                      },
                      child: const Text("Browse More Jobs"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
