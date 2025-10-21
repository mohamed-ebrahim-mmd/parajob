import 'package:flutter/material.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class JobSkillItem extends StatelessWidget {
  const JobSkillItem({super.key, required this.skill, this.onDelete});
  final String skill;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.hPct(5),

      padding: EdgeInsets.symmetric(
        horizontal: context.wPct(2),vertical: context.hPct(1),
      ),
      decoration: BoxDecoration(
        color: AppColors.aquaTeal8,
        border: Border.all(color: AppColors.aquaTeal),
        borderRadius: BorderRadius.circular(context.wPct(3)),
      ),
      child: Text(
        skill,textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.aquaTeal,
          fontSize: context.wPct(3.4),
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
