import 'package:flutter/material.dart';

class Neumorphism extends StatelessWidget {
  final double blurRadius;
  final Widget child;

  const Neumorphism({
    Key? key,
    required this.child,
    this.blurRadius = 15,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[500]!,
              offset: const Offset(4, 4),
              blurRadius: blurRadius,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Colors.white,
              offset: const Offset(-4, -4),
              blurRadius: blurRadius,
              spreadRadius: 1,
            )
          ]),
      child: Center(
        child: child,
      ),
    );
  }
}
