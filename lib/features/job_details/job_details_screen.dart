import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:para_job/features/job_details/job_details_controller.dart';
import 'package:para_job/packages/api_client/src/service/api_call_state_enum.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/error_screen.dart';

class JobDetailsScreen extends StatelessWidget {
    final job = Get.arguments as int;
    late final controller = Get.put(JobDetailsController(job));
    JobDetailsScreen({super.key,});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [


              
              Obx(() {

             

                
                switch (controller.jobDetailsCallState.value) {
                  case ApiCallState.loading:
                    return Container(
                      alignment: Alignment.center,
                      height: context.hPct(60),
                      child: CircularProgressIndicator(),
                    );
                  case ApiCallState.success:
                    final jobDetails = controller.jobData!.data;
                   
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                      Text(jobDetails.title),
                       Text(jobDetails.requirements),
                       Text(jobDetails.type)
                      ],
                    );
                  case ApiCallState.failure:
                    return ErrorScreen(
                      height: context.hPct(60),
                      onPressed: () {
                        controller.fetchJobDetails(56);
                      },
                    );
                }
             
             


              }),
           
           
           
          
        ],
        
      ) ,
    );
  }
}