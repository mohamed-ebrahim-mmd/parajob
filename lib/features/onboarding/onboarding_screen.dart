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
  int _previousIndex = 0;
  double _scrollOffset = 0.0;
  final GlobalKey<OnboardingView3State> _view3Key = GlobalKey();
  final GlobalKey<OnboardingView1State> _view1Key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _scrollOffset = _pageController.page ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double sidePreview = context.wPct(15);

    double dynamicOpacity = (1 - (_scrollOffset - 1).abs()).clamp(0.0, 1.0);
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
                  color: Color(0xB214181B), 
                  borderRadius: BorderRadius.circular(context.wPct(8)),
                ),
              ),
            ),
          ),

          OnboardingView2(offset: 0, opacity: dynamicOpacity),
          OnboardingView1(
            key: _view1Key,
            opacity: _scrollOffset <= 1.0 ? 1.0 : dynamicOpacity,

            offset:
                (sidePreview - (_scrollOffset * (screenWidth + sidePreview)))
                    .clamp(-screenWidth + sidePreview, sidePreview),
          ),

          OnboardingView3(
            key: _view3Key,

            opacity: _scrollOffset >= 1.0 ? 1.0 : dynamicOpacity,
            offset:
                (((2.0 - _scrollOffset) * (screenWidth + sidePreview)) -
                        sidePreview)
                    .clamp(-sidePreview, screenWidth - sidePreview),
          ),

          PageView.builder(
            controller: _pageController,
            itemCount: 3,
            onPageChanged: (index) {
              setState(() {
                if (index == 2) _view3Key.currentState?.playBounce();
                if (index == 1 && _previousIndex == 0)
                  _view1Key.currentState?.playBounce();
                _previousIndex = index;
                _currentIndex = index;
              });
            },

            itemBuilder: (context, index) => const SizedBox.expand(),
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
