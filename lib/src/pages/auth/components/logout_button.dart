import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../sign_controller.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SignController>();

    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18))),
        onPressed: () => {controller.onLogoutMobile()},
        child: const Text(
          'Logout',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ));
  }
}
