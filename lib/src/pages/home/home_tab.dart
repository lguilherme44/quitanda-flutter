import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:goya/src/config/custom_colors.dart';
import 'package:goya/src/controllers/cart_controller.dart';
import 'package:goya/src/controllers/category_controller.dart';
import 'package:goya/src/controllers/product_controller.dart';
import 'package:goya/src/main/factories/services/category/category_service.dart';
import 'package:goya/src/domain/models/categoties_model.dart';
import 'package:goya/src/domain/models/products_model.dart';
import 'package:goya/src/pages/auth/components/logout_button.dart';
import 'package:goya/src/pages/cart/cart_tab.dart';
import 'package:goya/src/pages/home/components/item_tile.dart';
import 'package:goya/src/pages/profile/profile_tab.dart';
import 'package:goya/src/utils/global_keys.dart';
import 'package:goya/src/utils/navigation_helper.dart';
import 'package:goya/src/utils/utils_services.dart';
import 'package:provider/provider.dart';
import 'components/category_tile.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final categoryService = makeCategoryService();
  final utilsServices = UtilsServices();

  final productController = ProductController();
  final categoryController = CategoryController();

  late FToast fToast;

  List<ProductsModel> products = [];
  List<CategoriesModel> categories = [];

  String selectedCategory = '';

  @override
  void initState() {
    super.initState();

    categoryController.fetchCategories();
    productController.fetchProductsFromId(1);

    productController.addListener(() {
      if (productController.state == ProductState.success) {
        setState(() {
          products = productController.products;
        });
      } else if (productController.state == ProductState.error) {
        customToasty();
      }
    });

    categoryController.addListener(() {
      if (categoryController.state == CategoryState.success) {
        setState(() {
          categories = categoryController.categories;
        });

        selectedCategory = categoryController.categories[0].name;
      } else if (categoryController.state == CategoryState.error) {
        customToasty();
      }
    });
  }

  void customToasty() {
    Fluttertoast.showToast(
      msg: 'Erro ao carregar produtos',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    CartController cartController = context.watch<CartController>();
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
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
                style: TextStyle(color: CustomColors.customConstrastColors),
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
                  label: Text(
                    '${cartController.cartItems.length}',
                    style: const TextStyle(color: Colors.white, fontSize: 11),
                  ),
                  child: IconButton(
                    onPressed: () {
                      NavigationHelper.navigateTo(context, const CartTab(),
                          replace: true);
                    },
                    icon: Icon(
                      Icons.shopping_cart,
                      key: cartIconKey,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      drawer: SafeArea(
        maintainBottomViewPadding: true,
        child: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: CustomColors.customSwatchColor,
                ),
                child: Center(
                  child: Text.rich(
                    TextSpan(
                      style: const TextStyle(fontSize: 20),
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
                ),
              ),
              ListTile(
                title: const Text('Carrinho'),
                onTap: () {
                  NavigationHelper.navigateTo(context, const CartTab());
                },
              ),
              ListTile(
                title: const Text('Meus pedidos'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Meu perfil'),
                onTap: () {
                  NavigationHelper.navigateTo(context, const ProfileTab());
                },
              ),
              ListTile(
                title: const Text('Lista de compras'),
                onTap: () {},
              ),
              const LogoutButton()
            ],
          ),
        ),
      ),
      body: productController.state == ProductState.loading
          ? Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: CustomColors.customSwatchColor,
                size: 120,
              ),
            )
          : Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
                        borderRadius: BorderRadius.circular(20),
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
                          selectedCategory = categories[index].name;
                          productController
                              .fetchProductsFromId(categories[index].id);
                        },
                        category: categories[index].name,
                        isSelected: categories[index].name == selectedCategory,
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
              ],
            ),
    );
  }
}
