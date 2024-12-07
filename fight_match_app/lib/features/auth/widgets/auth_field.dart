import 'package:flutter/material.dart';

import '../../../core/constants/palette.dart';

class AuthField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool isObscure;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;

  const AuthField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.isObscure = false,
    this.suffixIcon,
    this.onSuffixIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontFamily: 'Aileron',
                  fontWeight: FontWeight.w600,
                  color: Palette.textFieldHeader,
                ),
          ),
        ),
        TextField(
          controller: controller,
          obscureText: isObscure,
          obscuringCharacter: '*',
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus!.unfocus();
          },
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontFamily: 'Aileron',
                  fontWeight: FontWeight.w600,
                  color: Palette.textFieldHeader,
                ),
            labelStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontFamily: 'Aileron',
                  fontWeight: FontWeight.w600,
                  color: Palette.black,
                ),
            fillColor: Palette.textField,
            focusColor: Palette.textField,
            hoverColor: Palette.textField,
            hintText: hintText,
            suffixIcon: suffixIcon != null
                ? IconButton(
                    icon: Icon(suffixIcon),
                    onPressed: onSuffixIconPressed,
                  )
                : null,
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Palette.textField),
              borderRadius: BorderRadius.circular(16),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Palette.textField),
              borderRadius: BorderRadius.circular(16),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Palette.textField),
              borderRadius: BorderRadius.circular(16),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Palette.black,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ],
    );
  }
}
