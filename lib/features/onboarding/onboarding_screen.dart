/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-12 2:40 PM
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/onboarding/widgets/on_boarding_text.dart';
import 'package:para_job/features/onboarding/widgets/onboarding_view1.dart';
import 'package:para_job/features/onboarding/widgets/onboarding_view2.dart';
import 'package:para_job/features/onboarding/widgets/onboarding_view3.dart';
import 'package:para_job/packages/route_manager/controller/routing_controller.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/res/app_asset_paths.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final RoutingController routingController = Get.find();
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAssetPaths.getStartedBackground),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Container(
            width: double.infinity,
            height: double.infinity,
            color: Color(0xB2000000),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.hPct(2),
                vertical: context.hPct(8),
              ),
              child: Container(
                decoration: BoxDecoration(
                  //  border: Border.all(),
                  color: Color(0xB214181B), // #14181BB2,
                  borderRadius: BorderRadius.circular(context.wPct(8)),
                ),
              ),
            ),
          ),

          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            children: [
              OnboardingView1(),
              OnboardingView2(pageController: _pageController, pageIndex: 1),
              OnboardingView3(pageController: _pageController, pageIndex: 2),
            ],
          ),

          // Text at the bottom
          Positioned(
            bottom: context.hPct(10),
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.wPct(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // --- Onboarding Text ---
                  onBoardingText(pageIndex: _currentIndex),

                  context.hBox(4),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AnimatedSmoothIndicator(
                        activeIndex: _currentIndex,
                        count: 3,
                        effect: ExpandingDotsEffect(
                          dotHeight: 8,
                          dotWidth: 8,
                          activeDotColor: AppColors.aquaTeal,
                          dotColor: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.find<RoutingController>().goAuthChoiceScreen();
                        },
                        child: (Container(
                          padding: EdgeInsets.all(context.wPct(3)),
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              Text(
                                "skip",
                                style: TextStyle(fontSize: context.wPct(4)),
                              ),
                              context.wBox(1),
                              Icon(
                                Icons.double_arrow_rounded,
                                size: context.wPct(4),
                              ),
                            ],
                          ),
                        )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
