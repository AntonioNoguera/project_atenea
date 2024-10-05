import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart'; 
import 'package:proyect_atenea/src/presentation/values/app_theme.dart'; 

class ToggleButtonAtom extends StatelessWidget {
  
  //Initial Props
  final String text;
  final VoidCallback onPressed; 
  final bool isActive;

  //Dynamic Props
  final Color backgroundColor;   
  final TextStyle? textStyle = AppTextStyles.builder(
    color: AppColors.ateneaWhite,
    size: FontSizes.body2
  ); 

  //Fixed Props
  final double borderRadius = 10.0; 
  final EdgeInsetsGeometry padding = const EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0);
 
  ToggleButtonAtom({
    super.key, 
    required this.text,
    required this.onPressed,
    this.backgroundColor = AppColors.primaryColor,  
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? AppColors.primaryColor : AppColors.ateneaWhite ,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        side: isActive
              ? const BorderSide(
                  color: AppColors.primaryColor,
                  width: 1.5,
                  style: BorderStyle.solid,
                )
              : const BorderSide(
                  color: AppColors.primaryColor,
                  width: 1.5,
                  style: BorderStyle.solid,
                ), 
      ),
      //Vaya si no esta activo, entonces no se lanza nada literal
      onPressed: 
        !isActive ? onPressed : () {
            Fluttertoast.showToast(
            msg: 'Ya te encuentras en la pestaña de: ${text} !',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: AppColors.grayColor, // Color de fondo del toast
            textColor: AppColors.ateneaWhite,         // Color del texto
            fontSize: 16.0                   // Tamaño del texto
          );
        },
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: AppTextStyles.builder(
              color: isActive ? AppColors.ateneaWhite : AppColors.primaryColor,
              size: FontSizes.body2
            )
          ), 
        ],
      ),
    );
  }
}
