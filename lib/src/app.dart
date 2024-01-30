import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goya/src/config/custom_colors.dart';
import 'package:goya/src/controllers/cart_controller.dart';
import 'package:goya/src/controllers/category_controller.dart';
import 'package:goya/src/controllers/product_controller.dart';
import 'package:goya/src/pages/auth/sign_controller.dart';
import 'package:goya/src/pages/auth/sign_in_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:goya/src/pages/layout/base_screen.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignController()),
        ChangeNotifierProvider(create: (_) => ProductController()),
        ChangeNotifierProvider(create: (_) => CategoryController()),
        ChangeNotifierProvider(create: (_) => CartController())
      ],
      child: MaterialApp(
        title: 'Empório Goya',
        debugShowCheckedModeBanner: false,
        builder: FToastBuilder(),
        home: Consumer<SignController>(builder: (context, signController, _) {
          signController.isLogged();

          if (signController.state == AuthState.isLogout) {
            return const SignInScreen();
          } else {
            return const BaseScreen();
          }
        }),
        theme: ThemeData(
          textTheme: GoogleFonts.robotoTextTheme(),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Colors.grey,
          ),
          primarySwatch: Colors.grey,
          appBarTheme: AppBarTheme(
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            titleTextStyle: const TextStyle(
              color: Colors.white,
            ),
            backgroundColor: CustomColors.customSwatchColor,
          ),
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.grey[300],
        ),
      ),
    );
  }
}
