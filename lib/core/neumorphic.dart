import 'package:flutter/material.dart';
import 'theme.dart';

BoxDecoration neumorphicDecoration({double radius = 20.0}) {
  return BoxDecoration(
    color: cardColor,
    borderRadius: BorderRadius.circular(radius),
    boxShadow: [
      BoxShadow(color: lightShadow, offset: Offset(-6, -6), blurRadius: 10),
      BoxShadow(color: darkShadow, offset: Offset(6, 6), blurRadius: 10),
    ],
  );
}

BoxDecoration neumorphicInnerDecoration({double radius = 20.0}) {
  return BoxDecoration(
    color: cardColor,
    borderRadius: BorderRadius.circular(radius),
    boxShadow: [
      BoxShadow(color: darkShadow.withOpacity(0.2), offset: Offset(-3, -3), blurRadius: 6, spreadRadius: 1),
      BoxShadow(color: lightShadow.withOpacity(0.9), offset: Offset(3, 3), blurRadius: 6, spreadRadius: 1),
    ],
  );
}
