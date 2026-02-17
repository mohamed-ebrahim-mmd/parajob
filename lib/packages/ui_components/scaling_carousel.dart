//Mary Mark ||  mary.mark@moselaymd.com || Tue Feb 17 2026 11:07:43

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:para_job/features/home/home_controller.dart';
import 'package:para_job/features/home/widgets/hot_job_card.dart';
import 'package:para_job/packages/api_client/src/models/responses/job.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class ScalingCarousel extends StatefulWidget {
  final List<Job> jobs;
  const ScalingCarousel({super.key, required this.jobs});

  @override
  _ScalingCarouselState createState() => _ScalingCarouselState();
}

class _ScalingCarouselState extends State<ScalingCarousel> {
  late PageController _pageController;
  late double _currentPage;

  @override
  void initState() {
    super.initState();
    int middleIndex = (widget.jobs.length / 2)
        .floor(); //round the number down to the nearest integer
    _currentPage = middleIndex.toDouble();
    // 0.8 means the main item takes up 80% of the screen width,
    // leaving 10% visible on each side for the neighboring items.
    _pageController = PageController(
      viewportFraction: 0.7,
      initialPage: middleIndex,
    );

    // Listener to update state when scrolling
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.hPct(43.5),
      child: Center(
        child: PageView.builder(
          controller: _pageController,
          itemCount: widget.jobs.length, // Number of cards

          itemBuilder: (context, index) {
            // Calculate scale based on distance from center
            double scale = (1 - (_currentPage - index).abs() * 0.3).clamp(
              0.6,
              1.0,
            );

            return Transform.scale(
              scale: scale,

              child: HotJobCard(
                job: widget.jobs[index],
                onBookmarkTap: () {
                  Get.find<HomeController>().handleBookmarkTap(
                    widget.jobs[index],
                    context,
                  );
                },
                onTap: () {
                  Get.toNamed(
                    Routes.jobDetails,
                    arguments: widget.jobs[index].id,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
