import 'package:flutter/material.dart';
import 'package:goya/src/shared/components/glassmorphism.dart';

class ButtonCustom extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? icon;
  final Function onTapCallback;
  final Widget child;

  const ButtonCustom({
    Key? key,
    this.width,
    this.height,
    this.icon,
    required this.onTapCallback,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTapCallback(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) icon!,
          SizedBox(
            width: width ?? 210,
            height: height ?? 50,
            child: GlassMorphism(
              blur: 20,
              opacity: 0.2,
              child: Center(child: child),
            ),
          ),
        ],
      ),
    );
  }
}
