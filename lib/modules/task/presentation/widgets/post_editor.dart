import 'package:flutter/material.dart';
import 'package:task_manager/core/theme/app_parllete.dart';

class AppPostEditor extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final TextCapitalization textCapitalization;

  const AppPostEditor({
    super.key,
    this.validator,
    this.hintText,
    this.controller,
    this.textCapitalization = TextCapitalization.sentences,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: null,
      textCapitalization: textCapitalization,
      validator: validator,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(27),
        hintText: hintText,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppPallete.borderColor,
            width: 1,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppPallete.borderColor,
            width: 1,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppPallete.gradient2,
            width: 3,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppPallete.errorColor,
            width: 3,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }
}
