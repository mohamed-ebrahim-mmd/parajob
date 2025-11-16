//Mary Mark ||  mary.mark@moselaymd.com || Sun Nov 16 2025 13:16:45

import 'package:flutter/material.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class UserImg extends StatelessWidget {
  final String? profilePic;
  final bool isSelected;
  const UserImg({super.key, this.profilePic, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.wPct(7.4),
      height: context.wPct(7.4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? AppColors.aquaTeal : AppColors.grayButton,
          width: context.wPct(0.3),
        ),
      ),
      child: Center(
        child: Container(
          width: context.wPct(5.8),
          height: context.wPct(5.8),
          decoration: BoxDecoration(shape: BoxShape.circle),
          child: ClipOval(
            child: Image.network(
              profilePic ?? '',
              fit: BoxFit.cover,
              width: context.wPct(6),
              height: context.wPct(6),

              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: AppColors.lightGray2,
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: context.wPct(0.6),
                      color: AppColors.grayButton,
                    ),
                  ),
                );
              },

              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.person_off,
                  size: context.wPct(5),
                  color: AppColors.grayButton,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
