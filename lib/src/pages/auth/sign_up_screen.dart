import 'package:flutter/material.dart';
import 'package:goya/src/components/custom_text_field.dart';
import 'package:goya/src/config/custom_colors.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final cpfFormat = MaskTextInputFormatter(
      mask: '###.###.###-##', filter: {'#': RegExp(r'[0-9]')});

  final phoneFormat = MaskTextInputFormatter(
      mask: '(##) # ####-####', filter: {'#': RegExp(r'[0-9]')});

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
              child: Stack(
                children: [
                  Column(
                    children: [
                      const Expanded(
                        child: Center(
                          child: Text(
                            'Cadastro',
                            style: TextStyle(color: Colors.white, fontSize: 35),
                          ),
                        ),
                      ),

                      // Formulario
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 40),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(45))),
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
                              const CustomTextField(
                                icon: Icons.person,
                                label: 'Nome',
                              ),
                              CustomTextField(
                                icon: Icons.phone,
                                label: 'Celular',
                                inputFormatters: [phoneFormat],
                                typeField: TextInputType.phone,
                              ),
                              CustomTextField(
                                icon: Icons.file_copy,
                                label: 'CPF',
                                inputFormatters: [cpfFormat],
                                typeField: TextInputType.number,
                              ),
                              SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                        )),
                                    onPressed: () => {},
                                    child: const Text(
                                      'Cadastrar usuário',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    )),
                              ),
                            ]),
                      )
                    ],
                  ),
                  Positioned(
                    left: 10,
                    top: 10,
                    child: SafeArea(
                      child: IconButton(
                        onPressed: () => {Navigator.of(context).pop()},
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
