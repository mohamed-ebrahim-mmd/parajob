import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/job_details/complaint/complaint_controller.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

class ComplaintScreen extends StatelessWidget {
  final args = Get.arguments as Map<String, dynamic>;
  late final int id = args['id'];
  late final String title = args['title'];
  late final bool isCompany = args['isCompany'];
  late final controller = Get.put(ComplaintController(id, isCompany));

  final user = Get.find<UserController>();
  ComplaintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.charcoalBlack,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal:24,
        ),
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
              "Submit a complaint",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "about ",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.white50,
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
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
              decoration: InputDecoration(
                hintText: "Share your issues with us..",
              ),
            ),
            context.hBox(4),
            FilledButton(
              onPressed: () {
                controller.complaint(context);
              },
              child: Text("Submit your complaint"),
            ),
          ],
        ),
      ),
    );
  }
}
