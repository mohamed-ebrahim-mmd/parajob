import 'package:flutter/material.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class GradientProgressBar extends StatelessWidget {
  final double percentage; // 0 to 100

  const GradientProgressBar({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.hPct(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.wPct(1)),
        color: AppColors.lightGray2,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(context.wPct(1)),
        child: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [
              Color(0xFF00CBB8), // #00CBB8 at 0%
              Color.fromRGBO(0, 203, 184, 0.996875),
              Color.fromRGBO(0, 152, 138, 0.645957),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
          child: LinearProgressIndicator(
            value: percentage,
            backgroundColor: Colors.transparent,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      ),
    );
  }
}
