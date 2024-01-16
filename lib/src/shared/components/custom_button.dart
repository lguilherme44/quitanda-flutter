import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:goya/src/config/custom_colors.dart';

class CustomButton extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? icon;
  final TextStyle? textStyle;
  final BorderRadiusGeometry? borderRadius;
  final void Function()? onPressed;
  final String textButton;

  const CustomButton({
    super.key,
    this.width,
    this.height,
    this.icon,
    this.textStyle,
    this.borderRadius,
    required this.onPressed,
    required this.textButton,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height ?? 55,
        child: kIsWeb
            ? InkWell(
                onTap: () => onPressed,
              )
            : ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.customSecondaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: borderRadius ?? BorderRadius.circular(10),
                  ),
                ),
                onPressed: onPressed,
                label: Text(
                  textButton,
                  style: textStyle ??
                      const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                ),
                icon: icon ??
                    const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                    ),
              ));
  }
}
