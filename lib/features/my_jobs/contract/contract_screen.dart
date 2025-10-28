import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/packages/api_client/src/enums/api_call_state_enum.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:signature/signature.dart';

import '../../../packages/themeing/dashed_bottom_border_painter.dart';
import 'contract_controller.dart';

class ContractScreen extends StatelessWidget {
  ContractScreen({super.key});
  final int jobId = Get.arguments['jobId'];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ContractController(jobId: jobId));

    return Scaffold(
      backgroundColor: AppColors.charcoalBlack,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.wPct(5)),
          child: Obx(() {
            switch (controller.contractCallState.value) {
              case ApiCallState.loading:
                return const Center(child: CircularProgressIndicator());
              case ApiCallState.failure:
                return const Center(
                  child: Text(
                    'Failed to load contract. Please try again.',
                    style: TextStyle(color: AppColors.pureWhite),
                  ),
                );
              case ApiCallState.success:
                final contract = controller.contract;
                if (contract == null) {
                  return const Center(
                    child: Text(
                      'No contract found.',
                      style: TextStyle(color: AppColors.pureWhite),
                    ),
                  );
                }

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: context.hPct(2)),
                      Text(
                        contract.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: AppColors.pureWhite,
                        ),
                      ),
                      SizedBox(height: context.hPct(2)),
                      Text(
                        contract.content,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.pureWhite,
                        ),
                      ),
                      SizedBox(height: context.hPct(2)),
                      Obx(
                        () => Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Theme(
                              data: Theme.of(Get.context!).copyWith(
                                checkboxTheme: CheckboxThemeData(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  side: const BorderSide(
                                    color: AppColors.pureWhite,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              child: Checkbox(
                                value: controller.isAgreed.value,
                                onChanged: (value) {
                                  controller.isAgreed.value = value ?? false;
                                },
                                activeColor: AppColors.aquaTeal,
                                visualDensity: const VisualDensity(
                                  horizontal: -4,
                                  vertical: -4,
                                ),
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Expanded(
                              child: Text(
                                'Yes, I agree to all the terms and conditions.',
                                style: TextStyle(
                                  color: AppColors.pureWhite,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: context.hPct(2)),
                      const Text(
                        'Please sign with your signature below:',
                        style: TextStyle(
                          color: AppColors.pureWhite,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: context.hPct(1)),
                      SizedBox(
                        height: 200,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: CustomPaint(
                                painter: DashedBottomBorderPainter(),
                              ),
                            ),
                            Signature(
                              controller: controller.signatureController,
                              backgroundColor: Colors.transparent,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {
                            controller.signatureController.clear();
                          },
                          child: const Text(
                            'Clear',
                            style: TextStyle(color: AppColors.aquaTeal),
                          ),
                        ),
                      ),

                      SizedBox(height: 8),

                      FilledButton(
                        onPressed: controller.isAgreed.value
                            ? () => controller.verify(context)
                            : null,
                        child: const Text('Finish'),
                      ),
                    ],
                  ),
                );
            }
          }),
        ),
      ),
    );
  }
}
