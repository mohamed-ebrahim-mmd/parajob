import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/packages/api_client/src/enums/api_call_state_enum.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/error_screen.dart';
import 'package:signature/signature.dart';

import '../../../packages/themeing/dashed_bottom_border_painter.dart';
import 'contract_controller.dart';

class ContractScreen extends StatelessWidget {
  final controller = Get.find<ContractController>();

  ContractScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          controller.closeAndDispose();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: controller.closeAndDispose,
          ),
        ),
        backgroundColor: AppColors.charcoalBlack,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.defaultPadding),
            child: Obx(() {
              switch (controller.contractCallState.value) {
                case ApiCallState.loading:
                  return const Center(child: CircularProgressIndicator());
                case ApiCallState.failure:
                  return Center(
                    child: ErrorScreen(
                      onPressed: () {
                        controller.fetchContract();
                      },
                    ),
                  );
                case ApiCallState.success:
                  final contract = controller.contract;
                  if (contract == null) {
                    return Center(
                      child: Text(
                        'contract_no_found'.tr,
                        style: const TextStyle(color: AppColors.pureWhite),
                      ),
                    );
                  }

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        context.hBox(2),
                        Text(
                          contract.title,
                          style: TextStyle(
                            fontSize: context.wPct(5),
                            fontWeight: FontWeight.w600,
                            color: AppColors.pureWhite,
                          ),
                        ),
                        context.hBox(2),
                        Text(
                          contract.content,
                          style: TextStyle(
                            fontSize: context.wPct(4),
                            color: AppColors.pureWhite,
                          ),
                        ),

                        context.hBox(2),
                        Row(
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
                              child: Obx(() {
                                return Checkbox(
                                  value: controller.isAgreed.value,
                                  onChanged: (value) {
                                    controller.isAgreed.value = value ?? false;
                                  },
                                  activeColor: AppColors.aquaTeal,

                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                );
                              }),
                            ),
                            Expanded(
                              child: Text(
                                'contract_agree_terms'.tr,
                                style: TextStyle(
                                  color: AppColors.pureWhite,
                                  fontWeight: FontWeight.w400,
                                  fontSize: context.wPct(3.5),
                                ),
                              ),
                            ),
                          ],
                        ),
                        context.hBox(2),
                        Text(
                          'contract_sign_instruction'.tr,
                          style: TextStyle(
                            color: AppColors.pureWhite,
                            fontWeight: FontWeight.w800,
                            fontSize: context.wPct(3.6),
                          ),
                        ),
                        context.hBox(1),
                        SizedBox(
                          height: context.hPct(22),
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
                        context.hBox(1),
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: TextButton(
                            onPressed: () {
                              controller.signatureController.clear();
                            },
                            child: Text(
                              'contract_clear_button'.tr,
                              style: const TextStyle(color: AppColors.aquaTeal),
                            ),
                          ),
                        ),
                        context.hBox(1),
                        Obx(() {
                          return FilledButton(
                            onPressed: controller.isAgreed.value
                                ? () => controller.verify(context)
                                : null,
                            child: Text('contract_finish_button'.tr),
                          );
                        }),
                        context.hBox(2),
                      ],
                    ),
                  );
              }
            }),
          ),
        ),
      ),
    );
  }
}
