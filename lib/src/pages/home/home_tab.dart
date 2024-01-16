import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:goya/src/config/custom_colors.dart';
import 'package:goya/src/main/factories/services/category/category_service.dart';
import 'package:goya/src/domain/models/categoties_model.dart';
import 'package:goya/src/domain/models/products_model.dart';
import 'package:goya/src/pages/home/components/item_tile.dart';
import 'package:goya/src/utils/utils_services.dart';
import '../../main/factories/services/product/product_service.dart';
import 'components/category_tile.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final productService = makeProductService();
  final categoryService = makeCategoryService();
  final utilsServices = UtilsServices();

  late FToast fToast;

  List<ProductsModel> products = [];
  List<CategoriesModel> categories = [];

  String selectedCategory = '';

  @override
  void initState() {
    super.initState();
    getProducts();
    getCategories();
    getProductsFromCategory(1);
  }

  Future<List<ProductsModel>> getProducts() async {
    try {
      final fetchedProducts = await productService.load();
      return fetchedProducts;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<ProductsModel>> getProductsFromCategory(int categoryId) async {
    try {
      final fetchedProducts =
          await productService.filterProductsFromCategory(categoryId);

      products = fetchedProducts;
      setState(() {});
      return fetchedProducts;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<CategoriesModel>> getCategories() async {
    try {
      final fetchedCategories = await categoryService.load();
      if (fetchedCategories.isNotEmpty && selectedCategory == '') {
        selectedCategory = fetchedCategories[0].name;
      }

      return fetchedCategories;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([getProducts(), getCategories()]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              selectedCategory == '') {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: CustomColors.customSwatchColor,
                size: 120,
              ),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text('Error: ${snapshot.error}'),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data?.isEmpty == true) {
            return Container();
          } else {
            categories = snapshot.data![1];

            return Scaffold(
              appBar: AppBar(
                leading: Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () {},
                      tooltip: MaterialLocalizations.of(context)
                          .openAppDrawerTooltip,
                    );
                  },
                ),
                elevation: 0,
                centerTitle: true,
                title: Text.rich(
                  TextSpan(
                    style: const TextStyle(fontSize: 30),
                    children: [
                      const TextSpan(
                        text: 'Empório',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'Goya',
                        style: TextStyle(
                            color: CustomColors.customConstrastColors),
                      ),
                    ],
                  ),
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
                          label: const Text(
                            '0',
                            style: TextStyle(color: Colors.white, fontSize: 11),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.shopping_cart),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        isDense: true,
                        hintText: 'Pesquisar',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(60),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 25),
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) {
                        return CategoryTile(
                          onPressed: () {
                            setState(() {
                              selectedCategory = categories[index].name;
                              getProductsFromCategory(categories[index].id);
                            });
                          },
                          category: categories[index].name,
                          isSelected:
                              categories[index].name == selectedCategory,
                        );
                      },
                      separatorBuilder: (_, index) => const SizedBox(width: 10),
                      itemCount: categories.length,
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(16),
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 9 / 11.5,
                      ),
                      itemCount: products.length,
                      itemBuilder: (_, index) {
                        return ItemTile(
                          item: products[index],
                        );
                      },
                    ),
                  ),
                  if (products.isEmpty)
                    const Expanded(child: Text('Nenhum registro encontrado'))
                ],
              ),
            );
          }
        });
  }
}
