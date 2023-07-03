import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:goya/src/pages/auth/sign_up_screen.dart';
import 'package:goya/src/pages/layout/base_screen.dart';
import 'package:goya/src/config/custom_colors.dart';
import 'package:goya/src/components/custom_text_field.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

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
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const CustomTextField(
                            icon: Icons.email,
                            label: 'E-mail',
                            typeField: TextInputType.emailAddress,
                          ),
                          const CustomTextField(
                              icon: Icons.lock,
                              label: 'Password',
                              isSecret: true),

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
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(builder: (context) {
                                        return const BaseScreen();
                                      }))
                                    },
                                child: const Text(
                                  'Entrar',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                )),
                          ),

                          // Esqueceu a senha
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () => {},
                                child: Text(
                                  'Esqueceu a senha?',
                                  style: TextStyle(
                                      color:
                                          CustomColors.customConstrastColors),
                                )),
                          ),

                          // Divisorr
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Divider(
                                  color: Colors.grey.withAlpha(90),
                                  thickness: 1,
                                )),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Text('ou'),
                                ),
                                Expanded(
                                    child: Divider(
                                  color: Colors.grey.withAlpha(90),
                                  thickness: 1,
                                )),
                              ],
                            ),
                          ),

                          // Novo usuário
                          SizedBox(
                            height: 50,
                            child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18)),
                                    side: const BorderSide(
                                        width: 1, color: Colors.green)),
                                onPressed: () => {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (builder) {
                                        return SignUpScreen();
                                      }))
                                    },
                                child: const Text(
                                  'Criar conta',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.green),
                                )),
                          )
                        ]),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
