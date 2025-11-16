import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/job_details/complaint/company_complaint/company_complaint_controller.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class CompanyComplaintScreen extends StatelessWidget {
  final args = Get.arguments as Map<String, dynamic>;
  late final int id = args['id'];
  late final String title = args['title'];
  late final controller = Get.put(CompanyComplaintController(id));

  CompanyComplaintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.charcoalBlack,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: context.wPct(5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            context.hBox(6),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.pureWhite,
                size: 30,
              ),
            ),
            context.hBox(4),
            Text(
              'submit_complaint'.tr,
              style: TextStyle(
                fontSize: context.wPct(6),
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'about'.tr,
                  style: TextStyle(
                    fontSize: context.wPct(3.3),
                    fontWeight: FontWeight.w400,
                    color: AppColors.white50,
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: context.wPct(3.3),
                    fontWeight: FontWeight.w800,
                    color: AppColors.pureWhite,
                  ),
                ),
              ],
            ),
            context.hBox(2),
            TextField(
              controller: controller.detailsController,
              maxLines: 6,
              decoration: InputDecoration(hintText: 'complaint_hint'.tr),
            ),
            context.hBox(4),
            FilledButton(
              onPressed: () {
                controller.complaint(context);
              },
              child: Text('submit_complaint_button'.tr),
            ),
          ],
        ),
      ),
    );
  }
}
