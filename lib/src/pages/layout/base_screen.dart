import 'package:flutter/material.dart';
import 'package:goya/src/config/custom_colors.dart';
import 'package:goya/src/pages/auth/sign_in_screen.dart';
import 'package:goya/src/pages/home/home_tab.dart';
import 'package:goya/src/pages/profile/profile_tab.dart';
import 'package:goya/src/utils/navigation_helper.dart';
import 'package:provider/provider.dart';
import '../auth/sign_controller.dart';
import '../cart/cart_tab.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int currentIndex = 0;
  final pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          const HomeTab(),
          const CartTab(),
          Container(
            color: Colors.blue,
          ),
          const ProfileTab()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
              pageController.jumpToPage(index);
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: CustomColors.customSwatchColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withAlpha(99),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined),
              label: 'Carrinho',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Pedidos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Perfil',
            ),
          ]),
    );
  }
}
