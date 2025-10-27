import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/profile/contact_us/contact_us_controller.dart';
import 'package:para_job/features/profile/widgets/custom_listtile_contactus.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

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
                        vertical: context.hPct(1),horizontal: context.wPct(2),
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
                context.hBox(2),
                CustomListTileContactUs(title: "Email us on", subtitle: ""),
                 context.hBox(1),
                CustomListTileContactUs(title: "By phone", subtitle: ""),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.wPct(5),
            vertical: context.hPct(12),
          ),
          child: FilledButton(
            onPressed: () {
              controller.validateAndSubmit(context);
            },
            child: Text("Confirm"),
          ),
        ),
      ),
    );
  }
}
