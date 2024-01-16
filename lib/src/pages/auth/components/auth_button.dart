import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:goya/src/shared/components/glassmorphism.dart';
import 'package:provider/provider.dart';
import '../sign_controller.dart';

class AuthButton extends StatelessWidget {
  final double width;

  const AuthButton({Key? key, this.width = 200}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SignController>();
    return Center(
      child: InkWell(
        onTap: () => {
          if (kIsWeb) controller.onLoginWeb() else controller.onLoginMobile()
        },
        child: SizedBox(
          width: width,
          height: 320,
          child: const GlassMorphism(
            blur: 20,
            opacity: 0.2,
            child: Center(
              child: Text(
                'Entrar',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
