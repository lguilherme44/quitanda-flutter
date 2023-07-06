import 'package:flutter/material.dart';
import 'package:goya/src/config/custom_colors.dart';
import 'package:goya/src/pages/auth/sign_in_screen.dart';
import 'package:goya/src/pages/home/home_tab.dart';
import 'package:provider/provider.dart';
import '../auth/components/logout_button.dart';
import '../auth/sign_controller.dart';

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

    final controller = context.read<SignController>();

    controller.addListener(() {
      if (controller.state == AuthState.success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SignInScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          const HomeTab(),
          Container(
            color: Colors.yellow,
          ),
          Container(
            color: Colors.blue,
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 50,
                child: LogoutButton(),
              ),
            ],
          ),
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
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.white,
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
