import 'package:flutter/material.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';

class AteneaField extends StatelessWidget {
  final String? placeHolder;
  final String inputNameText;
  final double inputFontSize;
  final double inputBorderWidth;
  final double borderRadiusValue;
  final TextEditingController? controller;
  final bool enabled;
  final Widget? suffixIcon;

  const AteneaField({
    super.key,
    this.placeHolder,
    required this.inputNameText,
    this.controller,
    this.enabled = true,
    this.suffixIcon,
    this.inputFontSize = FontSizes.body1,
    this.inputBorderWidth = 1.3,
    this.borderRadiusValue = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: AppColors.primaryColor,
      controller: controller,
      enabled: enabled,
      style: TextStyle(
        fontFamily: 'RadioCanada',
        color: enabled ? AppColors.heavyPrimaryColor : AppColors.grayColor,
        fontSize: inputFontSize,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.ateneaWhite,
        labelText: inputNameText,
        labelStyle: TextStyle(
          fontFamily: 'RadioCanada',
          color: enabled ? AppColors.primaryColor : AppColors.grayColor,
          fontSize: inputFontSize,
        ),
        hintText: placeHolder,
        hintStyle: TextStyle(
          fontFamily: 'RadioCanada',
          color: AppColors.grayColor,
          fontSize: inputFontSize,
        ),
        suffixIcon: suffixIcon != null
            ? Padding(
                padding: const EdgeInsets.only(right: 13.0),
                child: suffixIcon,
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadiusValue),
          borderSide: BorderSide(
            color: AppColors.primaryColor,
            width: inputBorderWidth,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadiusValue),
          borderSide: BorderSide(
            color: AppColors.secondaryColor,
            width: inputBorderWidth + 0.5,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadiusValue),
          borderSide: BorderSide(
            color: AppColors.grayColor,
            width: inputBorderWidth,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadiusValue),
          borderSide: BorderSide(
            color: Colors.red,
            width: inputBorderWidth,
          ),
        ),
      ),
    );
  }
}
