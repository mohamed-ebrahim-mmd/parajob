/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2024-12-24 12:48 PM
 ==================================================================
*/

import 'package:flutter/material.dart';

extension MediaQueryValues on BuildContext {
  double get defaultPadding => sizePct(2);

  // Screen height
  double get h => MediaQuery.sizeOf(this).height;

  // Screen width
  double get w => MediaQuery.sizeOf(this).width;

  // Height as a percentage of the screen height
  double hPct(double percentage) {
    return h * (percentage / 100);
  }

  // Width as a percentage of the screen width
  double wPct(double percentage) {
    return w * (percentage / 100);
  }

  // Size as a percentage of the smaller dimension
  double sizePct(double percentage) {
    double smallerDimension = w < h ? w : h;
    return smallerDimension * (percentage / 100);
  }

  /// Represents a SizedBox with a specific height
  SizedBox hBox(double value) {
    return SizedBox(
      height: hPct(value),
    );
  }

  /// Represents a SizedBox with a specific width
  SizedBox wBox(double value) {
    return SizedBox(
      width: wPct(value),
    );
  }
}
