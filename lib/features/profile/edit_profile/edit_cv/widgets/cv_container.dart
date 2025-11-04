
import 'package:flutter/material.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class EditCvContainer extends StatelessWidget {
  const EditCvContainer({
    super.key, this.text, this.onEdit,
  });
  final String? text;
  final VoidCallback? onEdit;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onEdit,
      child: Center(
        child: Container(
          padding:  EdgeInsets.all(context.wPct(5),),
          color: AppColors.white5,
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(color: AppColors.darkNavy),
                child: Icon(Icons.picture_as_pdf_outlined
                  
                ),
              ),
              context.wBox(3),
              Text(text ?? "")
            ],
          ),
        ),
      ),
    );
  }
}
