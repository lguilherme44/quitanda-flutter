import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goya/src/config/custom_colors.dart';

class CustomTextField extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isSecret;
  final TextInputType? typeField;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
    super.key,
    required this.icon,
    required this.label,
    this.isSecret = false,
    this.typeField,
    this.inputFormatters,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscure = false;

  @override
  void initState() {
    super.initState();

    isObscure = widget.isSecret;
  }

  @override
  Widget build(BuildContext context) {
    TextInputType keyboardType = widget.typeField ?? TextInputType.text;

    return Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: TextFormField(
          initialValue: 'teste',
          inputFormatters: widget.inputFormatters,
          obscureText: isObscure,
          keyboardType: keyboardType,
          decoration: InputDecoration(
              prefixIcon: Icon(widget.icon),
              suffixIcon: widget.isSecret
                  ? IconButton(
                      onPressed: () => setState(() {
                            isObscure = !isObscure;
                          }),
                      icon: Icon(
                          isObscure ? Icons.visibility : Icons.visibility_off))
                  : null,
              labelText: widget.label,
              labelStyle: const TextStyle(fontSize: 15),
              floatingLabelStyle:
                  TextStyle(color: CustomColors.customSwatchColor),
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide(
                    color: CustomColors.customSecondaryColor,
                  ))),
        ));
  }
}
