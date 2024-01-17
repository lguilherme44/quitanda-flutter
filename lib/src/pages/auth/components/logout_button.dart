import 'package:flutter/material.dart';
import 'package:goya/src/config/custom_colors.dart';
import 'package:provider/provider.dart';
import '../sign_controller.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SignController>();

    return ListTile(
      title: Row(
        children: [
          Icon(
            Icons.logout,
            color: CustomColors.customSecondaryColor,
          ),
          const SizedBox(width: 7),
          Text(
            'Sair',
            style: TextStyle(
                color: CustomColors.customSwatchColor,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
      onTap: () => controller.onLogoutMobile(),
    );
  }
}
