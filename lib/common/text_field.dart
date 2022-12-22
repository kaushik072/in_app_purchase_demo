import 'package:flutter/material.dart';
import '../core/utils/colors.dart';

Widget textFormField(
    {required TextEditingController controller,
    required FormFieldValidator<String>? validator,
    required String hintText,
    required TextInputType? keyboardType,
    int? maxLength}) {
  return TextFormField(
    controller: controller,
    maxLength: maxLength,
    decoration: InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.primaryColor,
          width:2,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(
          color: AppColors.primaryColor,
          width: 1.5,
        ),
      ),
      hintText: hintText,
    ),
    keyboardType: keyboardType,
    validator: validator,
  );
}
