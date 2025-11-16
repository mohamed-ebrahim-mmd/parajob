//Mary Mark ||  mary.mark@moselaymd.com || Sun Nov 16 2025 11:59:09

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class LanguageTile extends StatelessWidget {
  final String title;
  final String flagAsset;
  final Locale value;
  final Locale groupValue;
  final Function(Locale) onChanged;

  const LanguageTile({
    super.key,
    required this.title,
    required this.flagAsset,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = value == groupValue;

    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: context.hPct(2)),
        padding: EdgeInsets.symmetric(
          horizontal: context.wPct(4),
          vertical: context.hPct(2.5),
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.pureWhite,
            width: context.wPct(0.3),
          ),
          borderRadius: BorderRadius.circular(context.wPct(3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// LEFT: Flag + Text
            Row(
              children: [
                SvgPicture.asset(flagAsset, height: context.hPct(3)),
                context.wBox(3),
                Text(title, style: TextStyle(fontSize: context.wPct(5),color: AppColors.grayButton)),
              ],
            ),

            /// RIGHT: Custom Radio Button
            Container(
              width: context.wPct(5.5),
              height: context.wPct(5.5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.aquaTeal : AppColors.grayButton,
                  width: context.wPct(0.5),
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: context.wPct(3),
                        height: context.wPct(3),
                        decoration: const BoxDecoration(
                          color: AppColors.aquaTeal,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
