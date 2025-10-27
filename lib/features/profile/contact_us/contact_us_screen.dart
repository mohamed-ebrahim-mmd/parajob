import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/profile/contact_us/contact_us_controller.dart';
import 'package:para_job/features/profile/widgets/custom_listtile_contactus.dart';
import 'package:para_job/packages/api_client/src/enums/api_call_state_enum.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/error_screen.dart';

class ContactUsScreen extends StatelessWidget {
  ContactUsScreen({super.key});

  final controller = Get.put(ContactUsController());

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

        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.wPct(5)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                context.hBox(2),
                Text(
                  'Complain or Suggest',
                  style: TextStyle(
                    color: AppColors.pureWhite,
                    fontSize: context.wPct(8.5),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                context.hBox(6),
                Obx(() {
                  return TextField(
                    controller: controller.messageController,
                    decoration: InputDecoration(
                      hintText: "Share your issues with us..",
                      errorText: controller.messageError.value,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: context.hPct(1),
                        horizontal: context.wPct(2),
                      ),
                    ),

                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    minLines: 4,
                    maxLines: 6,
                  );
                }),
                context.hBox(3),

                Text(
                  'Contact us',
                  style: TextStyle(
                    color: AppColors.pureWhite,
                    fontSize: context.wPct(8.5),

                    fontWeight: FontWeight.w600,
                  ),
                ),
                context.hBox(4),

                Obx(() {
                  final contact = controller.contactInfo;
                  switch (controller.contactCallState.value) {
                    case ApiCallState.loading:
                      return SizedBox(
                        height: context.hPct(15),
                        child: Center(child: const CircularProgressIndicator()),
                      );
                    case ApiCallState.success:
                      return Column(
                        children: [
                          CustomListTileContactUs(
                            title: "Email us on",
                            subtitle: contact!.email,
                          ),
                          context.hBox(1),
                          CustomListTileContactUs(
                            title: "By phone",
                            subtitle: contact.phoneNumber,
                          ),
                        ],
                      );
                    case ApiCallState.failure:
                      return Center(
                        child: ErrorScreen(
                          onPressed: () {
                            controller.fetchContactInfo();
                          },
                        ),
                      );
                  }
                }),
                context.hBox(8),

                FilledButton(
                  onPressed: () {
                    controller.validateAndSubmit(context);
                  },
                  child: Text("Submit your complaint"),
                ),
              ],
            ),
          ),
        ),

      ),
    );
  }
}
