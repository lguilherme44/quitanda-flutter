import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../sign_controller.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SignController>();
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18))),
        onPressed: () => {controller.onLogin()},
        child: const Text(
          'Entrar',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ));
  }
}
