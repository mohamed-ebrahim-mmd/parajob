import 'package:flutter/material.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

import '../themeing/app_colors.dart';

class AppStarRatingInteractive extends StatefulWidget {
  final double initialRating;
  final int maxStars;
  final Color color;
  final double size;
  final ValueChanged<double>? onChanged;

  const AppStarRatingInteractive({
    super.key,
    this.initialRating = 0,
    this.maxStars = 5,
    this.color = AppColors.aquaTeal,
    this.size = 14,
    this.onChanged,
  });

  @override
  State<AppStarRatingInteractive> createState() => _AppStarRatingInteractiveState();
}

class _AppStarRatingInteractiveState extends State<AppStarRatingInteractive> {
  late double _rating;

  @override
  void initState() {
    super.initState();
    _rating = widget.initialRating;
  }

  void _updateRating(int index) {
    setState(() {
      _rating = index.toDouble();
    });
    if (widget.onChanged != null) {
      widget.onChanged!(_rating);
    }
  }

  @override
  Widget build(BuildContext context) {
    final starSize = context.wPct(widget.size);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.maxStars, (index) {
        final starIndex = index + 1;
        IconData icon;
        if (starIndex <= _rating.floor()) {
          icon = Icons.star;
        } else if (starIndex - 0.5 == _rating) {
          icon = Icons.star_half;
        } else {
          icon = Icons.star_border;
        }

        return GestureDetector(
          onTap: () => _updateRating(starIndex),
          child: Icon(icon, color: widget.color, size: starSize),
        );
      }),
    );
  }
}
