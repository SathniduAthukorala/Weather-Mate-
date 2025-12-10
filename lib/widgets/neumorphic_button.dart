import 'package:flutter/material.dart';
import '../core/neumorphic.dart';

class NeumorphicButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;

  const NeumorphicButton({Key? key, required this.onTap, required this.child, this.padding = const EdgeInsets.symmetric(vertical: 14, horizontal: 20), this.radius = 16}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        decoration: neumorphicDecoration(radius: radius),
        child: Center(child: child),
      ),
    );
  }
}
