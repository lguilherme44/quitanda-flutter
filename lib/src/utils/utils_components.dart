import 'package:flutter/material.dart';
import 'package:goya/src/config/custom_colors.dart';
import 'package:goya/src/controllers/cart_controller.dart';
import 'package:goya/src/pages/home/home_tab.dart';
import 'package:goya/src/pages/layout/base_screen.dart';
import 'package:goya/src/shared/components/custom_button.dart';
import 'package:goya/src/utils/navigation_helper.dart';

Future<bool?> showOrderConfirmation(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 0,
            title: const Text('Confirmação'),
            content: const Text('Deseja realmente concluir o pedido?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text(
                  'Não',
                  style: TextStyle(color: CustomColors.customSwatchColor),
                ),
              ),
              CustomButton(
                height: 35,
                onPressed: () => Navigator.of(context).pop(true),
                textButton: 'Sim',
              ),
            ]);
      });
}

Future<bool?> showConfirmationClearCart(
    CartController cartController, BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 0,
            title: const Text('Confirmação'),
            content: const Text('Deseja realmente limpar o carrinho?'),
            actions: [
              TextButton(
                onPressed: () {
                  cartController.cleanCart();
                  NavigationHelper.navigateTo(
                    context,
                    const BaseScreen(),
                  );
                },
                child: Text(
                  'Sim',
                  style: TextStyle(color: CustomColors.customSwatchColor),
                ),
              ),
              CustomButton(
                height: 35,
                onPressed: () => Navigator.of(context).pop(false),
                textButton: 'Não',
              ),
            ]);
      });
}
