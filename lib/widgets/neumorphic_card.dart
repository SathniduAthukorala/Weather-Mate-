import 'package:flutter/material.dart';
import '../core/neumorphic.dart';

class NeumorphicCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;

  const NeumorphicCard({Key? key, required this.child, this.padding = const EdgeInsets.all(12), this.radius = 18}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: neumorphicDecoration(radius: radius),
      child: child,
    );
  }
}
