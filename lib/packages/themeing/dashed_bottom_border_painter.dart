import 'package:flutter/material.dart';

import 'app_colors.dart';

class DashedBottomBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const dashWidth = 8.0;
    const dashSpace = 4.0;
    final paint = Paint()
      ..color = AppColors.white40
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    double startX = 0;
    final y = size.height - 1;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, y), Offset(startX + dashWidth, y), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
