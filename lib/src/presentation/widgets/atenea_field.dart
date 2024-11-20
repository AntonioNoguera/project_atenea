import 'package:flutter/material.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';

class AteneaField extends StatefulWidget {
  final String? placeHolder;
  final String inputNameText;
  final double inputFontSize = FontSizes.body1;
  final double inputBorderWidth = 1.3;
  final double borderRadiusValue = 12.0;
  final TextEditingController? controller;
  final bool enabled;
  final bool isPasswordField;
  final Widget? suffixIcon;

  const AteneaField({
    super.key,
    this.placeHolder,
    required this.inputNameText,
    this.controller,
    this.enabled = true, // Default value is true
    this.isPasswordField = false, // Default value is false
    this.suffixIcon,
  });

  @override
  _AteneaFieldState createState() => _AteneaFieldState();
}

class _AteneaFieldState extends State<AteneaField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: AppColors.primaryColor,
      controller: widget.controller,
      enabled: widget.enabled, // Set the enabled property
      obscureText: widget.isPasswordField ? _obscureText : false, // Handle password field
      // Estilos del input en estado generico
      style: TextStyle(
        fontFamily: 'RadioCanada',
        color: widget.enabled ? AppColors.heavyPrimaryColor : AppColors.grayColor, // Change color if disabled
        fontSize: widget.inputFontSize,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.ateneaWhite,
        labelText: widget.inputNameText,
        labelStyle: TextStyle(
          fontFamily: 'RadioCanada',
          color: widget.enabled ? AppColors.primaryColor : AppColors.grayColor, // Change color if disabled
          fontSize: widget.inputFontSize,
        ),
        hintText: widget.placeHolder,
        hintStyle: TextStyle(
          fontFamily: 'RadioCanada',
          color: AppColors.grayColor,
          fontSize: widget.inputFontSize,
        ),
        suffixIcon: widget.isPasswordField
            ? Padding(
                padding: const EdgeInsets.only(right: 8.0), // Add right padding
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
              )
            : null,

        // Estilo de bordes habilitado y sin foco
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadiusValue), // Agrega el radio aquí
          borderSide: BorderSide(
            color: AppColors.primaryColor,
            width: widget.inputBorderWidth,
          ),
        ),

        // Borde cuando está enfocado
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadiusValue), // Agrega el radio aquí
          borderSide: BorderSide(
            color: AppColors.secondaryColor,
            width: widget.inputBorderWidth + 0.5,
          ),
        ),

        // Borde deshabilitado
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadiusValue), // Agrega el radio aquí
          borderSide: BorderSide(
            color: AppColors.grayColor,
            width: widget.inputBorderWidth,
          ),
        ),

        // Borde de error
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadiusValue), // Agrega el radio aquí
          borderSide: BorderSide(
            color: Colors.red,
            width: widget.inputBorderWidth,
          ),
        ),
      ),
    );
  }
}