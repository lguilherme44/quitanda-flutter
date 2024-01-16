import 'package:flutter/material.dart';
import 'package:goya/src/config/custom_colors.dart';

class CategoryTile extends StatelessWidget {
  final String category;
  final bool isSelected;
  final VoidCallback onPressed;

  const CategoryTile(
      {super.key,
      required this.category,
      required this.isSelected,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected
                ? CustomColors.customSwatchColor
                : Colors.transparent,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            category,
            style: TextStyle(
              color: isSelected
                  ? Colors.white.withAlpha(250)
                  : Colors.grey.shade600,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
