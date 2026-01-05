import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

Future<void> showDeductionDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      // Using context extension for responsive values
      double basePadding = context.defaultPadding;

      return Dialog(
        backgroundColor: AppColors.midnightBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.wPct(5)),
        ),
        child: Padding(
          padding: EdgeInsets.all(basePadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: context.wPct(6)),
                  Text(
                    'deduction_title'.tr,
                    style: TextStyle(
                      color: AppColors.pureWhite,
                      fontSize: context.wPct(4.5),
                      fontWeight: FontWeight.bold,
                      letterSpacing: context.wPct(0.3),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: AppColors.slateGray),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),

              SizedBox(height: context.hPct(2)), // Responsive height
              /// Message
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    color: AppColors.slateGray,
                    fontSize: context.wPct(3.5),
                  ), // Responsive font size
                  children: [
                    TextSpan(text: 'EGP '),
                    TextSpan(
                      text: '150.00',
                      style: TextStyle(
                        color: AppColors.pureWhite,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: ' ${'deduction_description'.tr} '),
                    TextSpan(
                      text: 'being_late'.tr,
                      style: TextStyle(
                        color: AppColors.pureWhite,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: context.hPct(2.5)),

              Container(
                padding: EdgeInsets.all(
                  context.wPct(3.5),
                ), // Responsive padding
                decoration: BoxDecoration(
                  color: AppColors.darkCharcoal,
                  borderRadius: BorderRadius.circular(context.wPct(3.5)),
                  border: Border.all(
                    color: AppColors.coralRed,
                    width: context.wPct(0.4),
                  ),
                ),
                child: Row(
                  children: [
                    /// Logo
                    Container(
                      width: context.wPct(11), // Responsive width
                      height: context.wPct(11), // Responsive height
                      decoration: BoxDecoration(
                        color: AppColors.pureWhite,
                        borderRadius: BorderRadius.circular(context.wPct(3)),
                      ),
                      child: Icon(Icons.music_note, color: AppColors.greenLeaf),
                    ),

                    SizedBox(width: context.wPct(3)), // Responsive width
                    /// Job Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'supervisor_at'.tr, // Localized text
                            style: TextStyle(
                              color: AppColors.coralRed,
                              fontWeight: FontWeight.bold,
                              fontSize: context.wPct(3.8),
                            ),
                          ),
                          SizedBox(height: context.hPct(1)),
                          Text(
                            'company_name'.tr, // Localized text
                            style: TextStyle(
                              color: AppColors.slateGray,
                              fontSize: context.wPct(3.2),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// Amount & Date
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '- EGP 150.00',
                          style: TextStyle(
                            color: AppColors.coralRed,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: context.hPct(1.5)),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: context.wPct(2.5),
                              color: AppColors.slateGray,
                            ),
                            SizedBox(width: context.wPct(1)),
                            Text(
                              'date_placeholder'.tr,
                              style: TextStyle(
                                color: AppColors.slateGray,
                                fontSize: context.wPct(2.5),
                              ),
                            ),
                          ],
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
    },
  );
}
