import 'package:flutter/material.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

Future<void> showApplicationDialog({
  required String message,
  String? warning,
  required String textButton,
  required BuildContext context,
  required void Function()? onTap,
}) async {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return AlertDialog(
        backgroundColor: AppColors.dialogBackgroundDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.wPct(3)),
        ),
        contentPadding: EdgeInsets.all(context.wPct(5)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.info_outline_rounded,
              color: Colors.white,
              size: context.hPct(6),
            ),
            context.hBox(2),

            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.pureWhite,
                fontSize: context.wPct(4.5),
                fontWeight: FontWeight.w500,
              ),
            ),
            context.hBox(3),

            OutlinedButton(
              onPressed: onTap,
              style: FilledButton.styleFrom(
                backgroundColor: Colors.transparent,
                side: BorderSide(color: AppColors.coralRed),
              ),
              child: Text(
                textButton,
                style: TextStyle(
                  color: AppColors.coralRed,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            context.hBox(1.5),
            if (warning != null)
              Text(
                warning,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: AppColors.lightGray,
                  fontSize: context.wPct(3.2),
                ),
              ),
          ],
        ),
      );
    },
  );
}
