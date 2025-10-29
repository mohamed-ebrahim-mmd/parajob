import 'package:flutter/material.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

import '../themeing/app_colors.dart';

class AppStarRating extends StatelessWidget {
  final double rating;
  final int maxStars;
  final Color color;
  final double size;

  const AppStarRating({
    super.key,
    required this.rating,
    this.maxStars = 5,
    this.color = AppColors.aquaTeal,
    this.size = 14,
  });

  @override
  Widget build(BuildContext context) {
    final starSize = context.wPct(size);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxStars, (index) {
        if (index + 1 <= rating.floor()) {
          return Icon(Icons.star, color: color, size: starSize);
        } else if (index < rating && rating < index + 1) {
          return Icon(Icons.star_half, color: color, size: starSize);
        } else {
          return Icon(Icons.star_border, color: color, size: starSize);
        }
      }),
    );
  }
}
