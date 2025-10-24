import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/app_star_rating_interactive.dart';

import '../employer_controller.dart';

class EmployerSubmitReview extends StatelessWidget {
  final controller = Get.find<EmployerController>();

  EmployerSubmitReview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Write a Review",
            style: TextStyle(
              fontSize: context.wPct(5),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: context.hPct(1.5)),

          Obx(
                () => AppStarRatingInteractive(
              initialRating: controller.selectedRating.value,
              onChanged: (rating) => controller.selectedRating.value = rating,
              size: context.wPct(1.6),
            ),
          ),

          SizedBox(height: context.hPct(2)),

          TextField(
            controller: controller.reviewController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: "Share your opinion with us..",
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 1.5),
                borderRadius: BorderRadius.circular(context.wPct(2.5)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.teal, width: 2),
                borderRadius: BorderRadius.circular(context.wPct(2.5)),
              ),
              filled: true,
              fillColor: Colors.transparent,
              contentPadding: EdgeInsets.all(context.wPct(3)),
            ),
          ),

          SizedBox(height: context.hPct(2)),
          FilledButton( onPressed: () { controller.submitReview(); }, child: Text("Submit"), ),
        ],
    );
  }
}
