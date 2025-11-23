// //Mary Mark ||  mary.mark@moselaymd.com || Sun Nov 23 2025 12:25:19

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:para_job/features/main_navigator/main_navigator_controller.dart';
// import 'package:para_job/features/my_notifications/strike/widgets/strikes_details.dart';
// import 'package:para_job/packages/api_client/src/enums/api_call_state_enum.dart';
// import 'package:para_job/packages/themeing/app_colors.dart';
// import 'package:para_job/packages/themeing/media_query_values.dart';
// import 'package:para_job/packages/ui_components/error_screen.dart';

// class BlockedScreen extends StatelessWidget {
//   BlockedScreen({super.key});
 
//   final controller = Get.find<MainNavigatorController>();

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: context.defaultPadding),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Obx(() {
//               switch (controller.isBlockedCallState.value) {
//                 case ApiCallState.loading:
//                   return Center(child: CircularProgressIndicator());

//                 case ApiCallState.success:
//                   return Column(
//                     children: [
//                       Text(
//                         "warning_label".tr,

//                         style: TextStyle(
//                           color: AppColors.rejected,
//                           fontSize: context.wPct(7),
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       context.hBox(1),

//                       Text(
//                         "violation_rules".tr,
//                         style: TextStyle(
//                           color: AppColors.pureWhite,
//                           fontSize: context.wPct(5),
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),

//                       context.hBox(1),
//                       StrikesDetails(),

//                       context.hBox(4),

//                       //Why you don’t want to get a warning?
//                       Align(
//                         alignment:
//                             Directionality.of(context) == TextDirection.rtl
//                             ? Alignment.centerRight
//                             : Alignment.centerLeft,
//                         child: Text(
//                           "warning_info_title".tr,
//                           style: TextStyle(
//                             color: AppColors.pureWhite,
//                             fontSize: context.wPct(5),
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                       Align(
//                         alignment:
//                             Directionality.of(context) == TextDirection.rtl
//                             ? Alignment.centerRight
//                             : Alignment.centerLeft,
//                         child: Text(
//                           "warning_consequences_list".tr,
//                           style: TextStyle(
//                             color: AppColors.softWhite80,
//                             fontSize: context.wPct(4),
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                       ),
//                       context.hBox(3),

//                       Align(
//                         alignment:
//                             Directionality.of(context) == TextDirection.rtl
//                             ? Alignment.centerRight
//                             : Alignment.centerLeft,
//                         child: Text(
//                           "warning_info_tips".tr,
//                           style: TextStyle(
//                             color: AppColors.pureWhite,
//                             fontSize: context.wPct(5),
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                       Align(
//                         alignment:
//                             Directionality.of(context) == TextDirection.rtl
//                             ? Alignment.centerRight
//                             : Alignment.centerLeft,
//                         child: Text(
//                           "warning_tips_list".tr,
//                           style: TextStyle(
//                             color: AppColors.softWhite80,
//                             fontSize: context.wPct(4),
//                             fontWeight: FontWeight.w400,
//                           ),
//                           textAlign: TextAlign.start,
//                         ),
//                       ),
//                       context.hBox(2),
//                     ],
//                   );

//                 case ApiCallState.failure:
//                   return Center(
//                     child: ErrorScreen(
//                       onPressed: () {
//                         controller.fetchBlockStatus();
//                       },
//                     ),
//                   );
//               }
//             }),
//           ),
//         ),
//       ),
//     );
//   }
// }
