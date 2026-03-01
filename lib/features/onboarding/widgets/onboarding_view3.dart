/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-13 11:11 AM
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:para_job/res/app_asset_paths.dart';

class OnboardingView3 extends StatefulWidget {
  final PageController pageController;
  final int pageIndex;
  const OnboardingView3({
    super.key,
    required this.pageIndex,
    required this.pageController,
  });

  @override
  State<OnboardingView3> createState() => _OnboardingView3State();
}

class _OnboardingView3State extends State<OnboardingView3>
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

    final page = widget.pageController.page ?? 2;

   
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
    return AnimatedBuilder(
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
          AppAssetPaths.onboardingScreenBackground3,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
