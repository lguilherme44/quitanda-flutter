import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:goya/src/shared/components/button_custom.dart';
import 'package:provider/provider.dart';
import '../sign_controller.dart';

class AuthButton extends StatelessWidget {
  final double width;

  const AuthButton({Key? key, this.width = 200}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SignController>();
    return Align(
      alignment: Alignment.center,
      child: ButtonCustom(
        width: MediaQuery.of(context).size.width * 0.8,
        onTapCallback: () {
          if (kIsWeb) {
            controller.onLoginWeb();
          } else {
            controller.onLoginMobile();
          }
        },
        child: const Text(
          'Entrar',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
