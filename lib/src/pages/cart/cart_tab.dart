import 'package:flutter/material.dart';
import 'package:goya/src/config/custom_colors.dart';
import 'package:goya/src/controllers/cart_controller.dart';
import 'package:goya/src/pages/cart/components/cart_tile.dart';
import 'package:goya/src/pages/layout/base_screen.dart';
import 'package:goya/src/shared/components/custom_button.dart';
import 'package:goya/src/utils/navigation_helper.dart';
import 'package:goya/src/utils/utils_components.dart';
import 'package:goya/src/utils/utils_services.dart';
import 'package:provider/provider.dart';

class CartTab extends StatefulWidget {
  const CartTab({super.key});

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  final utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    CartController cartController = context.watch<CartController>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            NavigationHelper.navigateTo(context, const BaseScreen());
          },
        ),
        title: const Text(
          'Carrinho',
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: GestureDetector(
                onTap: () {},
                child: Badge(
                  backgroundColor: CustomColors.customConstrastColors,
                  alignment: Alignment.topRight,
                  label: Text(
                    '${cartController.cartItems.length}',
                    style: const TextStyle(color: Colors.white, fontSize: 11),
                  ),
                  child: IconButton(
                    onPressed: () async {
                      await showConfirmationClearCart(cartController, context);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartController.cartItems.length,
              itemBuilder: (_, index) {
                return CartTile(
                  cartItem: cartController.cartItems[index],
                  remove: (cartItem) =>
                      cartController.removeFromCart(cartItem.product),
                );
              },
            ),
          ),
          const SizedBox(),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 3,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  utilsServices
                      .priceToCurrency(cartController.cartTotalPrice()),
                  style: TextStyle(
                    fontSize: 23,
                    color: CustomColors.customSwatchColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColors.customSwatchColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () async {
                      bool? result = await showOrderConfirmation(context);

                      print(result);
                    },
                    child: const Text(
                      'Concluir pedido',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
