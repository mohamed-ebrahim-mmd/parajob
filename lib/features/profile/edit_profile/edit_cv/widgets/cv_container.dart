import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart'
    show Trans;
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/res/app_asset_paths.dart';

class EditCvContainer extends StatelessWidget {
  const EditCvContainer({
    super.key,
    required this.text,
    this.onEdit,
    this.onShowPdf,
  });

  final String text;
  final VoidCallback? onEdit;
  final VoidCallback? onShowPdf;

  @override
  Widget build(BuildContext context) {
    final type = text.contains(".") ? text.split(".").last : "unknown";
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white5,
          borderRadius: BorderRadius.circular(context.wPct(2)),
        ),
        padding: EdgeInsets.all(context.wPct(4)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. FIRST ITEM: Image/Icon
            Container(
              width: context.wPct(10),
              height: context.wPct(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(context.wPct(2)),
                color: AppColors.white5,
              ),
              clipBehavior: Clip.antiAlias,
              padding: EdgeInsets.all(context.wPct(1)),
              child: Image.asset(AppAssetPaths.pdfIcon, fit: BoxFit.contain),
            ),

            context.wBox(3),

            // 2. SECOND ITEM: Column of the rest of the items
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Filename Text
                  context.hBox(0.5),
                  Text(
                    text,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: context.wPct(4),
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),

                  context.hBox(0.5),
                  //hard coded last uploaded
                  Text(
                    "last_uploaded".tr,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: context.wPct(3.5),
                      color: AppColors.gray8D,
                    ),
                  ),

                  // Slider / Divider Line
                  Padding(
                    padding: EdgeInsets.only(
                      top: context.wPct(3),
                      bottom: context.wPct(3),
                    ),
                    child: Divider(
                      color: Colors.grey.withOpacity(0.2),
                      thickness: 1,
                      height: 1,
                    ),
                  ),

                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // View Details Action
                      if (type == "pdf") ...[
                        GestureDetector(
                          onTap: onShowPdf,
                          child: Row(
                            children: [
                              Icon(
                                Icons.remove_red_eye_outlined,
                                size: context.wPct(4.5),
                                color: AppColors.aquaTeal,
                              ),
                              context.wBox(1.5),
                              Text(
                                "cv_view_details".tr,
                                style: TextStyle(
                                  color: AppColors.aquaTeal,
                                  fontSize: context.wPct(3.5),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        context.wBox(4),
                      ],

                      GestureDetector(
                        onTap: onEdit,
                        child: Row(
                          children: [
                            Icon(
                              Icons.cloud_upload_outlined,
                              size: context.wPct(5),
                              color: AppColors.oceanBlue,
                            ),
                            context.wBox(1.5),
                            Text(
                              "upload".tr,
                              style: TextStyle(
                                color: AppColors.oceanBlue,
                                fontSize: context.wPct(3.5),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
