/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-12 2:40 PM
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/onboarding/widgets/onboarding_view1.dart';
import 'package:para_job/features/onboarding/widgets/onboarding_view2.dart';
import 'package:para_job/features/onboarding/widgets/onboarding_view3.dart';
import 'package:para_job/packages/route_manager/controller/routing_controller.dart';

class OnboardingScreen extends StatelessWidget {
  final RoutingController routingController = Get.find();

  OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: const [
          OnboardingView1(),
          OnboardingView2(),
          OnboardingView3(),
        ],
      ),
    );
  }
}
