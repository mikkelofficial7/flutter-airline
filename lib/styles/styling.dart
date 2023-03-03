import 'package:flutter/material.dart';
import 'package:sample_flutter/constants/colorconstant.dart';

class Styling {
  TextStyle? titleTextStyle() {
    return const TextStyle(fontSize: 20, color: ColorConstant.black, fontWeight: FontWeight.bold);
  }

  TextStyle? titleTextStyleSmall() {
    return const TextStyle(fontSize: 12, color: ColorConstant.black, fontWeight: FontWeight.bold);
  }

  TextStyle? contentTextStyle() {
    return const TextStyle(fontSize: 14, color: ColorConstant.primaryColor, fontStyle: FontStyle.italic);
  }

  LinearGradient gradientBackground(Color from, Color to) {
    return LinearGradient(
        colors: [from, to,],
        begin: FractionalOffset(0.0, 0.0),
        end: FractionalOffset(1.0, 1.0),
        stops: [0.0, 1.0],
        tileMode: TileMode.clamp
    );
  }
}