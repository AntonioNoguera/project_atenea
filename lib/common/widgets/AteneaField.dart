
import 'package:flutter/material.dart';
import '../../core/utils/AppTheme.dart';

class AteneaField extends StatelessWidget {
  final String placeHolder;
  final String inputNameText;

  final double inputFontSize = FontSizes.body1;
  final double inputBorderWidth = 1.3;

  const AteneaField({
    super.key, 
    required this.placeHolder,
    required this.inputNameText
  });

  @override
  Widget build(BuildContext context){
    return TextField(

      //Estilos del input en estado generico
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
          color: AppColors.primaryColor, 
          fontSize: inputFontSize,
        ),

        hintText: placeHolder,
        hintStyle: TextStyle(
          fontFamily: 'RadioCanada',
          color: AppColors.grayColor,
          fontSize: inputFontSize,
        ),
        
        //habilitado y sin foco
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.primaryColor,
            width: inputBorderWidth,
          ),
        ),
        

        //Bordes
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.secondaryColor, // Color del borde cuando el campo está enfocado
            width: inputBorderWidth + 0.5,
          ),
        ),
        
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.grayColor,  
            width: inputBorderWidth,
          ),
        ), 

        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: inputBorderWidth,
          ),
        ),
      ),
    );
  }
}