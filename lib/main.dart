import 'package:flutter/material.dart';
import 'package:goya/src/pages/auth/sign_in_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quitanda Goya',
      theme: ThemeData(
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Colors.grey,
          ),
          primarySwatch: Colors.green,
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white.withAlpha(190)),
      debugShowCheckedModeBanner: false,
      home: const SignInScreen(),
    );
  }
}
