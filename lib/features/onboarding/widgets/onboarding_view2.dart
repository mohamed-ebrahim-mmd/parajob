/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-13 11:11 AM
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:para_job/res/app_asset_paths.dart';

class OnboardingView2 extends StatefulWidget {
  final PageController pageController;
  final int pageIndex;
  const OnboardingView2({
    super.key,
    required this.pageIndex,
    required this.pageController,
  });

  @override
  State<OnboardingView2> createState() => _OnboardingView2State();
}

class _OnboardingView2State extends State<OnboardingView2>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool animationStarted = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 210),
    );

    _animation = Tween<double>(
      begin: 0,
      end: -0.02,
    ).chain(CurveTween(curve: Curves.easeOut)).animate(_controller);

    widget.pageController.addListener(_checkPage);
  }

  void _checkPage() {
    if (animationStarted) return;

    final page = widget.pageController.page ?? 0;

    // Check if the page is close to the current page
    if ((page - widget.pageIndex).abs() < 0.01) {
      animationStarted = true;
      _controller.forward().then((_) => _controller.reverse());
    }
  }

  @override
  void dispose() {
    widget.pageController.removeListener(_checkPage);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        AnimatedBuilder(
          animation: widget.pageController,
          builder: (context, child) {
            double page = widget.pageController.hasClients
                ? widget.pageController.page ?? widget.pageIndex.toDouble()
                : widget.pageIndex.toDouble();

            // Calculate opacity based on distance from center
            double opacity = (1 - (page - widget.pageIndex).abs()).clamp(
              0.0,
              1.0,
            );

            return Opacity(opacity: opacity, child: child);
          },
          child: Image.asset(
            AppAssetPaths.onboardingScreenBackgroundCenter,
            fit: BoxFit.cover,
          ),
        ),
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(
                _animation.value * MediaQuery.of(context).size.width,
                0,
              ),
              child: child,
            );
          },
          child: Align(
            alignment: Alignment.topLeft,
            child: Image.asset(
              AppAssetPaths.onboardingScreenBackgroundLeft,
              fit: BoxFit.cover,
            ),
          ),
        ),

        Align(
          alignment: Alignment.topRight,
          child: Image.asset(
            AppAssetPaths.onboardingScreenBackgroundRight,
            // height: double.infinity,
          ),
        ),
      ],
    );
  }
}
