import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goya/src/config/custom_colors.dart';
import 'package:goya/src/pages/auth/sign_controller.dart';
import 'package:goya/src/pages/auth/sign_in_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:goya/src/pages/home/home_tab.dart';
import 'package:goya/src/pages/product/product_controller.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignController()),
        ChangeNotifierProvider(create: (_) => ProductController())
      ],
      child: MaterialApp(
        title: 'Empório Goya',
        debugShowCheckedModeBanner: false,
        builder: FToastBuilder(),
        // darkTheme: ThemeData.dark(),
        // themeMode: ThemeMode.light,
        home: const SignInScreen(),
        routes: {
          '/callback': (context) => const HomeTab(),
        },
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
