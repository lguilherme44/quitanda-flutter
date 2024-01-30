import 'package:flutter/material.dart';
import 'package:goya/src/config/custom_colors.dart';
import 'package:goya/src/pages/auth/sign_controller.dart';
import 'package:goya/src/shared/components/custom_text_field.dart';
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
            onPressed: () {
              controller.onLogoutMobile();
            },
            icon: Icon(
              Icons.logout,
              color: CustomColors.customSecondaryColor,
            ),
          )
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[400],
              child: ClipOval(
                child: Image.network(
                  controller.user?.user.pictureUrl.toString() ?? '',
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.person,
                      color: Colors.grey,
                      size: 40,
                    );
                  },
                ),
              ),
            ),
          ),
          if (controller.user?.user.name != null)
            CustomTextField(
              icon: Icons.email,
              label: 'Nome',
              initialValue: controller.user?.user.name,
            ),
          if (controller.user?.user.email != null)
            CustomTextField(
              icon: Icons.email,
              label: 'E-mail',
              initialValue: controller.user?.user.email,
              typeField: TextInputType.emailAddress,
            ),
          if (controller.user?.user.phoneNumber != null)
            CustomTextField(
              icon: Icons.email,
              label: 'Celular',
              initialValue: controller.user?.user.phoneNumber,
              typeField: TextInputType.phone,
            ),
        ],
      ),
    );
  }
}
