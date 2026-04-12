import 'package:flutter/material.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class CompanyDetailContainer extends StatelessWidget {
  final String title;
  final String value;

  const CompanyDetailContainer({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: context.w,
      padding: EdgeInsets.symmetric(
        horizontal: context.wPct(2),
        vertical: context.hPct(2),
      ),
      decoration: BoxDecoration(
        color: Color(0x0DFFFFFF),
        borderRadius: BorderRadius.circular(context.wPct(2)),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: context.wPct(4),
              ),
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
            context.hBox(0.5),
            FittedBox(
              fit: BoxFit.scaleDown,

              child: Text(
                "$value +",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: context.wPct(9),
                ),
                softWrap: true,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
