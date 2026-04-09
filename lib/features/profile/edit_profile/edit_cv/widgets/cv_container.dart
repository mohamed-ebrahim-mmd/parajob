import 'package:flutter/material.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class EditCvContainer extends StatelessWidget {
  const EditCvContainer({
    super.key,
    required this.text,
    this.onEdit,
    this.onShowPdf,
  });

  final String text;
  final VoidCallback? onEdit;
  final VoidCallback? onShowPdf;

  @override
  Widget build(BuildContext context) {
    final type = text.contains(".") ? text.split(".").last : "unknown";
    return GestureDetector(
      onTap: onEdit,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white5,
            borderRadius: BorderRadius.circular(context.wPct(3)),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: context.wPct(2),
            vertical: context.hPct(1),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(context.wPct(2)),

                    decoration: BoxDecoration(
                      color: AppColors.darkNavy,
                      borderRadius: BorderRadius.circular(context.wPct(3)),
                    ),
                    child: CvIcon(type: type),
                  ),
                  context.wBox(3),
                  Expanded(
                    child: Text(
                      text,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  context.wBox(3),
                  type == "pdf"
                      ? IconButton(
                          onPressed: onShowPdf,
                          icon: Icon(
                            Icons.remove_red_eye,
                            size: context.wPct(4.5),
                            color: AppColors.accepted,
                          ),
                        )
                      : Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CvIcon extends StatelessWidget {
  const CvIcon({super.key, this.type});

  final String? type;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(
          Icons.file_open_rounded,
          color: AppColors.coralRed,
          size: context.wPct(11),
        ),
        Text(
          type ?? "",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: context.wPct(3.5),
            color: Colors.white, // optional for visibility
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
