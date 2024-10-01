import 'package:flutter/material.dart';
import 'package:proyect_atenea/app/values/app_theme.dart';

class AteneaField extends StatelessWidget {
  final String placeHolder;
  final String inputNameText;

  final double inputFontSize = FontSizes.body1;
  final double inputBorderWidth = 1.3;
  final double borderRadiusValue = 12.0; // Define el radio de las esquinas

  const AteneaField({super.key, required this.placeHolder, required this.inputNameText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      // Estilos del input en estado generico
      style: TextStyle(
        fontFamily: 'RadioCanada',
        color: AppColors.heavyPrimaryColor,
        fontSize: inputFontSize,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.ateneaWhite,
        labelText: inputNameText,
        labelStyle: TextStyle(
          fontFamily: 'RadioCanada',
          color: AppColors.lightPrimaryColor,
          fontSize: inputFontSize,
        ),
        hintText: placeHolder,
        hintStyle: TextStyle(
          fontFamily: 'RadioCanada',
          color: AppColors.grayColor,
          fontSize: inputFontSize,
        ),

        // Estilo de bordes habilitado y sin foco
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadiusValue), // Agrega el radio aquí
          borderSide: BorderSide(
            color: AppColors.primaryColor,
            width: inputBorderWidth,
          ),
        ),

        // Borde cuando está enfocado
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadiusValue), // Agrega el radio aquí
          borderSide: BorderSide(
            color: AppColors.secondaryColor,
            width: inputBorderWidth + 0.5,
          ),
        ),

        // Borde deshabilitado
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadiusValue), // Agrega el radio aquí
          borderSide: BorderSide(
            color: AppColors.grayColor,
            width: inputBorderWidth,
          ),
        ),

        // Borde de error
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadiusValue), // Agrega el radio aquí
          borderSide: BorderSide(
            color: Colors.red,
            width: inputBorderWidth,
          ),
        ),
      ),
    );
  }
}
