import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goya/src/config/custom_colors.dart';
import 'package:goya/src/pages/auth/sign_in_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:goya/src/pages/home/home_tab.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quitanda Goya',
      debugShowCheckedModeBanner: false,
      builder: FToastBuilder(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      home: const SignInScreen(),
      routes: {
        '/callback': (context) => const HomeTab(),
      },
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.grey,
        ),
        primarySwatch: Colors.green,
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
        scaffoldBackgroundColor: Colors.white.withAlpha(190),
      ),
    );
  }
}
