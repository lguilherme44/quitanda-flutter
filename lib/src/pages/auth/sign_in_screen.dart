import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auth0_flutter/auth0_flutter_web.dart';
import 'package:flutter/material.dart';
import 'package:goya/src/pages/auth/components/auth_button.dart';
import 'package:goya/src/pages/auth/sign_controller.dart';
import 'package:goya/src/pages/layout/base_screen.dart';
import 'package:goya/src/config/custom_colors.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late final SignController controller;
  late Auth0Web auth0Web;

  @override
  void initState() {
    super.initState();

    final controller = context.read<SignController>();

    if (kIsWeb) {
      controller.initializeAuth0Web();
      auth0Web = controller.auth0Web!;
      auth0Web.onLoad().then(
            (final credentials) => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const BaseScreen()),
            ),
          );
    }

    controller.addListener(() {
      if (controller.state == AuthState.success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const BaseScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          backgroundColor: CustomColors.customSwatchColor,
          body: SingleChildScrollView(
            child: SizedBox(
              height: size.height,
              width: size.width,
              child: Column(
                children: [
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Nome do App
                      Text.rich(TextSpan(
                          style: const TextStyle(fontSize: 40),
                          children: [
                            const TextSpan(
                                text: 'Quitanda',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: 'Goya',
                                style: TextStyle(
                                    color: CustomColors.customConstrastColors))
                          ])),

                      // Categorias
                      SizedBox(
                        height: 35,
                        child: DefaultTextStyle(
                          style: const TextStyle(fontSize: 25),
                          child: AnimatedTextKit(
                              pause: Duration.zero,
                              repeatForever: true,
                              animatedTexts: [
                                FadeAnimatedText('Frutas'),
                                FadeAnimatedText('Legumes'),
                                FadeAnimatedText('Verduras'),
                              ]),
                        ),
                      )
                    ],
                  )),
                  // Formulario
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 40),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(45)),
                    ),
                    child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Entrar
                          SizedBox(
                            height: 50,
                            child: AuthButton(),
                          ),
                        ]),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
