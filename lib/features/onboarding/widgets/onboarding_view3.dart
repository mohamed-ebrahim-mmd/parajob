// /*
//  Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-13 11:11 AM
//  ==================================================================
// */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/res/app_asset_paths.dart';

class OnboardingView3 extends StatefulWidget {
  final double offset;
  final double opacity;

  const OnboardingView3({
    super.key,

    required this.offset,
    required this.opacity,
  });

  @override
  State<OnboardingView3> createState() => OnboardingView3State();
}

class OnboardingView3State extends State<OnboardingView3>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool animationStarted = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    _animation = Tween<double>(
      begin: 0,
      end: -0.05,
    ).chain(CurveTween(curve: Curves.easeOut)).animate(_controller);
  }

  void playBounce() {
    if (!_controller.isAnimating) {
      _controller.reset();
      _controller.forward().then((_) => _controller.reverse());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(widget.offset, 0),
      child: Opacity(
        opacity: widget.opacity,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(_animation.value * context.width, 0),
              child: child,
            );
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Image.asset(
              AppAssetPaths.rightOnboardingScreen,
              height: context.hPct(96),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
