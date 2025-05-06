import 'package:flutter/material.dart';

Widget buildCustomTextField({
  required BuildContext context,
  required String title,
  required Icon leftIcon,
  required TextEditingController controller,
  required String? Function(String?) validator,
  bool isPassword = false,
  bool obscureText = false,
  VoidCallback? onVisibilityToggle,
}) {
  return TextFormField(
    controller: controller,
    obscureText: isPassword ? obscureText : false,
    validator: validator,
    decoration: InputDecoration(
      labelText: title,
      prefixIcon: leftIcon,
      suffixIcon: isPassword
          ? IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: onVisibilityToggle,
            )
          : null,
    ),
  );
}
