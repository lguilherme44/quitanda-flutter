import 'package:flutter/material.dart';
import 'package:goya/src/config/custom_colors.dart';
import 'package:goya/src/controllers/cart_controller.dart';
import 'package:goya/src/domain/models/products_model.dart';
import 'package:goya/src/pages/home/components/fly_to_cart.dart';
import 'package:goya/src/pages/product/product_screen.dart';
import 'package:goya/src/utils/global_keys.dart';
import 'package:goya/src/utils/navigation_helper.dart';
import 'package:goya/src/utils/utils_services.dart';
import 'package:provider/provider.dart';

class ItemTile extends StatelessWidget {
  final ProductsModel item;

  ItemTile({
    super.key,
    required this.item,
  });

  final UtilsServices utilsServices = UtilsServices();

  void _startAddToCartAnimation(
      BuildContext context, ProductsModel item, RenderBox box) {
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => FlyToCartAnimation(
        startPosition: box.localToGlobal(Offset.zero),
        endPosition: _getCartIconPosition(),
        item: item,
      ),
    );

    Overlay.of(context).insert(overlayEntry);

    // Aguarde o fim da animação antes de remover o overlay
    Future.delayed(const Duration(seconds: 1), () {
      overlayEntry.remove();
    });
  }

  Offset _getCartIconPosition() {
    RenderBox box = cartIconKey.currentContext?.findRenderObject() as RenderBox;
    return box.localToGlobal(Offset.zero);
  }

  @override
  Widget build(BuildContext context) {
    final cartController = context.read<CartController>();

    return Stack(
      children: [
        // Conteudo
        GestureDetector(
          onTap: () {
            NavigationHelper.navigateTo(
              context,
              ProductScreen(
                item: item,
              ),
            );
          },
          child: Card(
            elevation: 1,
            color: Colors.white,
            shadowColor: Colors.grey.shade100,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Imagem
                  Expanded(
                    child: Hero(
                      tag: item.imgUrl,
                      child: Image.asset(item.imgUrl),
                    ),
                  ),
                  // Nome
                  Text(
                    item.itemName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  // Preço - Unidade
                  Row(
                    children: [
                      Text(
                        utilsServices.priceToCurrency(item.price),
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.normal,
                          fontSize: 20,
                        ),
                      ),
                      Text('/${item.unit}',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        // Botão add carrinho
        Positioned(
            top: 4,
            right: 4,
            child: GestureDetector(
              onTap: () {
                cartController.addToCart(item);
                _startAddToCartAnimation(
                    context, item, context.findRenderObject() as RenderBox);
              },
              child: Container(
                height: 40,
                width: 35,
                decoration: BoxDecoration(
                    color: CustomColors.customSwatchColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      topRight: Radius.circular(20),
                    )),
                child: const Icon(
                  Icons.add_shopping_cart_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ))
      ],
    );
  }
}
