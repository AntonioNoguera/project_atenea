import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/utils/AppTheme.dart';

class AteneaButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;   
  final TextStyle? textStyle;
  final String? svgIcon;

  // Constant data of the button
  final double borderRadius = 10.0;
  final double iconSize = 35.0;
  final EdgeInsetsGeometry padding = const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0);

  AteneaButton({
    super.key, 
    required this.text,
    required this.onPressed,
    this.backgroundColor = AppColors.primaryColor, 
    TextStyle? textStyle,
    this.svgIcon
  }) : textStyle = textStyle ?? AppTextStyles.builder(color: AppColors.ateneaWhite, size: FontSizes.body1); // Lo hacemos aquí.


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          Text(
            text,
            style: textStyle,
          ),

          if (svgIcon != null) // Solo se renderiza si svgIcon no es nulo
            Padding(
              padding: const EdgeInsets.only(left: 8.0), // Añade espacio entre el ícono y el texto
              child: SvgPicture.asset(
                svgIcon!, // Usa el operador "!" porque ya verificamos que no es nulo
                height: iconSize,
                width: iconSize,
              ),
            ),
        ],
      ),
    );
  }
}
