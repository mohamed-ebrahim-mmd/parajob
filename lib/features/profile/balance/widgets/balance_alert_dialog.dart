import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

Future<void> showDeductionDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      double basePadding = context.defaultPadding;

      return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: context.wPct(5)),
        backgroundColor: AppColors.midnightBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.wPct(5)),
        ),
        child: Padding(
          padding: EdgeInsets.all(basePadding * 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  context.wBox(6),
                  Text(
                    'Deduction'.tr,
                    style: TextStyle(
                      color: AppColors.pureWhite,
                      fontSize: context.wPct(6.4),
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

              context.hBox(2.5),

              /// Message
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    color: AppColors.lightSilverGray,
                    fontSize: context.wPct(5),
                  ),
                  children: const [
                    TextSpan(text: 'EGP '),
                    TextSpan(
                      text: '150.00',
                      style: TextStyle(
                        color: AppColors.pureWhite,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: ' will be deducted due to '),
                    TextSpan(
                      text: 'being late',
                      style: TextStyle(
                        color: AppColors.pureWhite,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              context.hBox(2.5),

              /// Deduction card
              Container(
                padding: EdgeInsets.all(context.wPct(3.5)),
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
                      width: context.wPct(11),
                      height: context.wPct(11),
                      decoration: BoxDecoration(
                        color: AppColors.pureWhite,
                        borderRadius: BorderRadius.circular(context.wPct(3)),
                      ),
                      child: Icon(Icons.music_note, color: AppColors.greenLeaf),
                    ),

                    context.wBox(3),

                    /// Job Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Supervisor',
                            style: TextStyle(
                              color: AppColors.coralRed,
                              fontWeight: FontWeight.bold,
                              fontSize: context.wPct(3.8),
                            ),
                          ),
                          context.hBox(1),
                          Text(
                            'Company Name',
                            style: TextStyle(
                              color: AppColors.coralRed,
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
                        const Text(
                          '- EGP 15000.00',
                          style: TextStyle(
                            color: AppColors.coralRed,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        context.hBox(1.5),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: context.wPct(2.5),
                              color: AppColors.coralRed,
                            ),
                            context.wBox(1),
                            Text(
                              '20 Sep 2025',
                              style: TextStyle(
                                color: AppColors.coralRed,
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
