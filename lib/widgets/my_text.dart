import 'package:flutter/material.dart';

import '../constants/color_manger.dart';
import '../constants/font_manger.dart';

class MyText extends StatelessWidget {
  final String title;
  final Color? color;
  final double? size;
  final double? letterSpace;
  final double? wordSpace;
  final String? fontFamily;
  final TextAlign? alien;
  final TextDecoration? decoration;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;
  final int? maxLines;

  const MyText(
      {super.key, required this.title,
        this.color,
        required this.size,
        this.alien,
        this.fontFamily,
        this.decoration,
        this.letterSpace,
        this.wordSpace,
        this.overflow,
        this.maxLines,
        this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: alien ?? TextAlign.start,
      // textScaleFactor:WidgetUtils.lang == "ar"? 1 : 1.2,
      style: TextStyle(
          color: color ?? ColorManager.black,
          fontSize: size??18,
          letterSpacing: letterSpace,
          wordSpacing:wordSpace,
          decoration: decoration ?? TextDecoration.none,
          fontWeight: fontWeight ?? FontWeight.normal,
          fontFamily: fontFamily ?? FontManager.fontFamily),
      overflow: overflow,
      maxLines: maxLines,
      textWidthBasis: TextWidthBasis.longestLine,
      // locale: Locale(WidgetUtils.lang),
    );
  }
}