import 'package:flutter/material.dart';
import 'package:goya/src/domain/models/products_model.dart';

class FlyToCartAnimation extends StatefulWidget {
  final Offset startPosition;
  final Offset endPosition;
  final ProductsModel item;

  const FlyToCartAnimation({
    super.key,
    required this.startPosition,
    required this.endPosition,
    required this.item,
  });

  @override
  FlyToCartAnimationState createState() => FlyToCartAnimationState();
}

class FlyToCartAnimationState extends State<FlyToCartAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = Tween<Offset>(
      begin: widget.startPosition,
      end: widget.endPosition,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Positioned(
          left: _animation.value.dx,
          top: _animation.value.dy,
          child: child ?? Container(),
        );
      },
      child: const Icon(
        Icons.shopping_cart,
        size: 24.0,
        color: Colors.white,
      ),
    );
  }
}
