import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class CustomContainerJobDetail extends StatelessWidget {
  final String text;
  final String iconPath;
  const CustomContainerJobDetail({
    super.key,
    required this.text,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: context.w,
      padding: EdgeInsets.symmetric(
        horizontal: context.wPct(3),
        vertical: context.hPct(2),
      ),
      decoration: BoxDecoration(
        color: Color(0x0DFFFFFF),
        borderRadius: BorderRadius.circular(context.wPct(2)),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(iconPath),
            context.wBox(1),
            Flexible(
              child: Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: context.wPct(4),
                ),
                softWrap: true,
                overflow: TextOverflow.visible,
              ),
            ),

            //  Text(text, style: TextStyle(fontWeight: FontWeight.w400 ,fontSize: context.wPct(4)),),
          ],
        ),
      ),
    );
  }
}
