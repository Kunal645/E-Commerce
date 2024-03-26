import 'package:flutter/material.dart';
import '../color_constant.dart';
import '../text_style.dart';

Widget commonTextField(TextEditingController controller, String hint){
  return  TextField(
    controller: controller,
    style: TextStyles.k14Regular(),
    decoration: InputDecoration(
      border: const UnderlineInputBorder(),
      hintText: hint,
      hintStyle: TextStyles.k14Regular(color: hintText),
    ),
  );
}

Widget commonPasswordField(TextEditingController controller,bool showPassword, hint,onTap){
  return TextField(
    controller: controller,
    style: TextStyles.k14Regular(),
    obscureText: !showPassword,
    decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        hintText: hint,
        hintStyle: TextStyles.k14Regular(color: hintText),
        suffixIcon: InkWell(
            onTap: onTap,
            child: Icon(!showPassword ? Icons.visibility : Icons.visibility_off)
        )
    ),
  );
}