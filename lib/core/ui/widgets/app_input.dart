import 'package:flutter/material.dart';
import 'package:task_manager/core/theme/app_parllete.dart';

class AppInput extends StatefulWidget {
  const AppInput({
    super.key,
    this.controller,
    this.hintText,
    this.validator,
    this.obscureText = false,
    this.maxLines = 1,
    this.maxLength,
    this.textCapitalization = TextCapitalization.sentences,
    this.keyboardType = TextInputType.text,
    this.label,
    this.labelText,
    this.enabled = true,
    this.readOnly = false,
    this.onChanged,
    this.suffixIcon,
    this.onTap,
    this.focusNode,
  });

  final TextEditingController? controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextCapitalization textCapitalization;
  final String? Function(String?)? onChanged;
  final int? maxLines;
  final int? maxLength;
  final TextInputType keyboardType;
  final Widget? label;
  final String? labelText;
  final bool enabled;
  final bool readOnly;
  final Widget? suffixIcon;
  final Function()? onTap;
  final FocusNode? focusNode;

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  bool obscureText = false;

  @override
  void initState() {
    super.initState();

    obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: obscureText,
      obscuringCharacter: '\u{25CF}',
      textCapitalization: widget.textCapitalization,
      onTap: widget.onTap,
      focusNode: widget.focusNode,
      enabled: widget.enabled,
      maxLength: widget.maxLength,
      maxLines: obscureText ? 1 : widget.maxLines,
      keyboardType: widget.keyboardType,
      readOnly: widget.readOnly,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(27),
        hintText: widget.hintText,
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
        suffixIcon: !widget.obscureText
            ? null
            : obscureText
                ? Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      child: const Icon(
                        Icons.remove_red_eye,
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      child: const Icon(
                        Icons.visibility_off,
                      ),
                    ),
                  ),
      ),
    );
  }
}
