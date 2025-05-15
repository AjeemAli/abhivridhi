import 'package:abhivridhiapp/core/utils/app_color.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final String hint;
  final Color? labelColor;
  final FontWeight? fontWeight;
  final Color? borderColor;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onSuffixTap;
  final TextInputAction textInputAction;
  final FocusNode? focusNode;
  final bool enabled;
  final int maxLines;

  const CustomTextField({
    super.key,
    this.controller,
    required this.label,
    required this.hint,
    this.prefixIcon,
    this.suffixIcon,
    required this.obscureText,
    required this.keyboardType,
    this.validator,
    this.onChanged,
    this.onSuffixTap,
    required this.textInputAction,
    this.focusNode,
    required this.enabled,
    required this.maxLines,
    this.labelColor = Colors.grey,
    this.fontWeight,
    this.borderColor = Colors.grey, required  Function(dynamic value) onSubmitted, String? errorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      focusNode: focusNode,
      enabled: enabled,
      maxLines: maxLines,
      style: const TextStyle(fontSize: 14, color: Colors.black87),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: labelColor,fontWeight: fontWeight),
        hintText: hint,
        hintStyle:  TextStyle(color: Colors.grey,fontWeight: fontWeight),
        prefixIcon:
            prefixIcon != null ? Icon(prefixIcon, color: AppColors.primary) : null,
        suffixIcon:
            suffixIcon != null
                ? GestureDetector(
                  onTap: onSuffixTap,
                  child: Icon(suffixIcon, color: labelColor),
                )
                : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: borderColor!, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
        ),
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }
}
