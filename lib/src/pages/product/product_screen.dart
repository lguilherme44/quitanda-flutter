import 'package:flutter/material.dart';
import 'package:goya/src/config/custom_colors.dart';
import 'package:goya/src/controllers/cart_controller.dart';
import 'package:goya/src/domain/models/products_model.dart';
import 'package:goya/src/pages/cart/cart_tab.dart';
import 'package:goya/src/shared/components/custom_button.dart';
import 'package:goya/src/shared/components/quantity_widget.dart';
import 'package:goya/src/utils/navigation_helper.dart';
import 'package:goya/src/utils/utils_services.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.item});

  final ProductsModel item;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final UtilsServices utilsServices = UtilsServices();

  int cartItemQuantity = 1;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CartController>();

    return Scaffold(
      backgroundColor: Colors.white.withAlpha(220),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
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
                    '${controller.cartItems.length}',
                    style: const TextStyle(color: Colors.white, fontSize: 11),
                  ),
                  child: IconButton(
                    onPressed: () {
                      NavigationHelper.navigateTo(context, const CartTab());
                    },
                    icon: const Icon(
                      Icons.shopping_cart,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          // Conteudo
          Column(
            children: [
              Expanded(
                child: Hero(
                  tag: widget.item.imgUrl,
                  child: Image.asset(widget.item.imgUrl),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(32),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        //Nome - Quantidade
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.item.itemName,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 27, fontWeight: FontWeight.bold),
                              ),
                            ),
                            QuantityWidget(
                              suffixText: widget.item.unit,
                              value: cartItemQuantity,
                              result: (quantity) {
                                setState(() {
                                  cartItemQuantity = quantity;
                                });
                              },
                            )
                          ],
                        ),
                        // Preço
                        Text(
                          utilsServices.priceToCurrency(widget.item.price),
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: CustomColors.customSwatchColor,
                          ),
                        ),

                        // Descrição
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            child: SingleChildScrollView(
                              child: Text(widget.item.description,
                                  style: const TextStyle(
                                    height: 1.5,
                                  )),
                            ),
                          ),
                        ),

                        // Botão
                        CustomButton(
                          textButton: 'Adicionar ao carrinho',
                          onPressed: () {
                            controller.addToCart(widget.item);
                          },
                        ),
                      ]),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
