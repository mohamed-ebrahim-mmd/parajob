
import 'package:flutter/material.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class GradientProgressBar extends StatelessWidget {
  final double percentage; // 0 to 100

  const GradientProgressBar({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    final progress = (percentage.clamp(0, 100)) / 100; // ensure between 0–1
    return Container(
      height: context.hPct(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.lightGray2,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            //  stops: [0.0, 0.0001, 0.701, 1.0],
            colors: [
              Color(0xFF00CBB8), // #00CBB8 at 0%
              Color.fromRGBO(
                0,
                203,
                184,
                0.996875,
              ), // rgba(0,203,184,0.996875) at 0.01%
              Color.fromRGBO(
                0,
                152,
                138,
                0.645957,
              ), // rgba(0,152,138,0.645957) at 70.1%
              Color.fromRGBO(1, 57, 52, 0), // rgba(1,57,52,0) at 100%
              //AppColors.lightGray2,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.transparent,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      ),
    );
  }
}

