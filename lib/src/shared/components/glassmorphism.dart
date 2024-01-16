import 'package:flutter/material.dart';
import 'dart:ui';

class GlassMorphism extends StatelessWidget {
  final double? blur;
  final double? opacity;
  final double? borderRadius;
  final Widget child;

  const GlassMorphism({
    Key? key,
    this.borderRadius,
    required this.child,
    this.blur,
    this.opacity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur ?? 20, sigmaY: blur ?? 0.2),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(opacity ?? 0.2),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 20)),
            border: Border.all(
              width: 1.5,
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
