import 'package:flutter/material.dart';
import 'package:goya/src/config/custom_colors.dart';
import 'package:goya/src/domain/models/products_model.dart';
import 'package:goya/src/shared/components/custom_button.dart';
import 'package:goya/src/shared/components/quantity_widget.dart';
import 'package:goya/src/utils/utils_services.dart';

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
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(220),
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
                          onPressed: () {},
                        ),
                        // SizedBox(
                        //   height: 55,
                        //   child: ElevatedButton.icon(
                        //     style: ElevatedButton.styleFrom(
                        //         backgroundColor: CustomColors.customSwatchColor,
                        //         shape: RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.circular(15),
                        //         )),
                        //     onPressed: ,
                        //     label: const Text(
                        //      ,
                        //       style: TextStyle(
                        //           color: Colors.white,
                        //           fontSize: 18,
                        //           fontWeight: FontWeight.bold),
                        //     ),
                        //     icon: const Icon(
                        //       Icons.shopping_cart_outlined,
                        //       color: Colors.white,
                        //     ),
                        //   ),
                        // ),
                      ]),
                ),
              )
            ],
          ),

          Positioned(
            left: 10,
            top: 10,
            child: SafeArea(
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.arrow_back_ios,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
