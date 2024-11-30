import 'package:flutter/material.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';

class AteneaPasswordField extends StatefulWidget {
  final String? placeHolder;
  final String inputNameText;
  final double inputFontSize;
  final double inputBorderWidth;
  final double borderRadiusValue;
  final TextEditingController? controller;
  final bool enabled;

  const AteneaPasswordField({
    super.key,
    this.placeHolder,
    required this.inputNameText,
    this.controller,
    this.enabled = true,
    this.inputFontSize = FontSizes.body1,
    this.inputBorderWidth = 1.3,
    this.borderRadiusValue = 12.0,
  });

  @override
  _AteneaPasswordFieldState createState() => _AteneaPasswordFieldState();
}

class _AteneaPasswordFieldState extends State<AteneaPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: AppColors.primaryColor,
      controller: widget.controller,
      enabled: widget.enabled,
      obscureText: _obscureText,
      style: TextStyle(
        fontFamily: 'RadioCanada',
        color: widget.enabled ? AppColors.heavyPrimaryColor : AppColors.grayColor,
        fontSize: widget.inputFontSize,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.ateneaWhite,
        labelText: widget.inputNameText,
        labelStyle: TextStyle(
          fontFamily: 'RadioCanada',
          color: widget.enabled ? AppColors.primaryColor : AppColors.grayColor,
          fontSize: widget.inputFontSize,
        ),
        hintText: widget.placeHolder,
        hintStyle: TextStyle(
          fontFamily: 'RadioCanada',
          color: AppColors.grayColor,
          fontSize: widget.inputFontSize,
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 13.0), // Espaciado agregado
          child: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: AppColors.primaryColor,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadiusValue),
          borderSide: BorderSide(
            color: AppColors.primaryColor,
            width: widget.inputBorderWidth,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadiusValue),
          borderSide: BorderSide(
            color: AppColors.secondaryColor,
            width: widget.inputBorderWidth + 0.5,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadiusValue),
          borderSide: BorderSide(
            color: AppColors.grayColor,
            width: widget.inputBorderWidth,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadiusValue),
          borderSide: BorderSide(
            color: Colors.red,
            width: widget.inputBorderWidth,
          ),
        ),
      ),
    );
  }
}
