//Mary Mark ||  mary.mark@moselaymd.com || Sun Nov 23 2025 14:59:47

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/registration/contact_us_auth/contact_us_auth_controller.dart';
import 'package:para_job/packages/api_client/src/enums/api_call_state_enum.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/contact_us_list_tile.dart';
import 'package:para_job/packages/ui_components/error_screen.dart';

class ContactUsAuthScreen extends StatelessWidget {
  ContactUsAuthScreen({super.key});

  final controller = Get.put(ContactUsAuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: Get.back,
        ),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            context.hBox(2),

            Text(
              'contact_us_heading'.tr,
              style: TextStyle(
                color: AppColors.pureWhite,
                fontSize: context.wPct(6),

                fontWeight: FontWeight.w600,
              ),
            ),
            context.hBox(1),

            Obx(() {
              final contact = controller.contactInfo;
              switch (controller.contactCallState.value) {
                case ApiCallState.loading:
                  return Expanded(
                    child: SizedBox(
                      height: context.hPct(15),
                      child: Center(child: const CircularProgressIndicator()),
                    ),
                  );
                case ApiCallState.success:
                  return Column(
                    children: [
                      ContactUsListTile(
                        title: 'contact_us_email_title'.tr,
                        subtitle: contact!.email,
                      ),
                    ],
                  );
                case ApiCallState.failure:
                  return Expanded(
                    child: Center(
                      child: ErrorScreen(
                        onPressed: () {
                          controller.fetchContactInfo();
                        },
                      ),
                    ),
                  );
              }
            }),
          ],
        ),
      ),
    );
  }
}
