import 'package:flutter/material.dart';
import 'package:goya/src/pages/auth/sign_controller.dart';
import 'package:goya/src/pages/common_widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SignController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Perfil do usuário',
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          IconButton(
            onPressed: () => controller.onLogoutMobile(),
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        children: const [
          CustomTextField(icon: Icons.email, label: 'E-mail'),
          CustomTextField(icon: Icons.email, label: 'Nome'),
          CustomTextField(icon: Icons.email, label: 'Celular'),
          CustomTextField(icon: Icons.email, label: 'CPF', isSecret: true),
        ],
      ),
    );
  }
}
