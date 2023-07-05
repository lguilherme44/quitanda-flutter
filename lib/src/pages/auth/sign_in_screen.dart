import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:goya/src/pages/auth/sign_up_screen.dart';
import 'package:goya/src/pages/layout/base_screen.dart';
import 'package:goya/src/config/custom_colors.dart';
import 'package:goya/src/components/custom_text_field.dart';
import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String domain = dotenv.get('AUTH0_DOMAIN');
    String clientId = dotenv.get('AUTH0_CLIENTE_ID');

    final size = MediaQuery.of(context).size;
    final auth0 = Auth0(domain, clientId);

    const appScheme = 'greengrocer';

    void onLogin(Function() navigateToScreen) async {
      final isSuccessLogin =
          await auth0.webAuthentication(scheme: appScheme).login();

      if (isSuccessLogin != null && isSuccessLogin.accessToken != null) {
        navigateToScreen();
      } else {
        print('Failed to obtain Access Token');
      }
    }

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
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Entrar
                          SizedBox(
                            height: 50,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18))),
                                onPressed: () => {
                                      onLogin(() {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const BaseScreen()),
                                        );
                                      })
                                    },
                                child: const Text(
                                  'Entrar',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                )),
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
