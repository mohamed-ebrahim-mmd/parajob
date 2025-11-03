import 'package:flutter/material.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class SkillItem extends StatelessWidget {
  const SkillItem({super.key, required this.skill, this.onDelete});
  final String skill;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.hPct(5),

      padding: EdgeInsets.only(
        left:  context.wPct(3),
      ),
      decoration: BoxDecoration(
        color: AppColors.aquaTeal8,
        border: Border.all(color: AppColors.aquaTeal),
        borderRadius: BorderRadius.circular(context.wPct(3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            skill,
            style: TextStyle(
              color: AppColors.aquaTeal,
              fontSize: context.wPct(3.4),
              fontWeight: FontWeight.w400,
            ),
          ),
         // Flexible(child: SizedBox()),
          IconButton(
            onPressed: onDelete,
            icon: Icon(
              Icons.close,
              color: AppColors.aquaTeal,
              size: context.wPct(4),
            ),
          ),
        ],
      ),
    );
  }
}
