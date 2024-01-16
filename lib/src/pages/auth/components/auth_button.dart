import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:goya/src/shared/components/custom_button.dart';
import 'package:provider/provider.dart';
import '../sign_controller.dart';

class AuthButton extends StatelessWidget {
  final double width;

  const AuthButton({Key? key, this.width = 200}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SignController>();
    return SizedBox(
      width: width,
      child: CustomButton(
        onPressed: () {
          if (kIsWeb) {
            controller.onLoginWeb();
          } else {
            controller.onLoginMobile();
          }
        },
        textButton: 'Entrar',
        icon: const Icon(
          Icons.login,
          color: Colors.white,
        ),
      ),
    );
  }
}
