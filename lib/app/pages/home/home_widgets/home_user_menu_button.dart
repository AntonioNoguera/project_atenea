import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proyect_atenea/app/values/AppTheme.dart';

class HomeUserMenuButton extends StatelessWidget {
  final String? text;
  final VoidCallback onPressed;
  final Color backgroundColor;   
  final TextStyle? textStyle;
  final String? svgIcon;

  final double borderRadius = 10.0;
  final double iconSize = 35.0;
  final EdgeInsetsGeometry padding = const EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0);

  final bool enabledBorder;
  final bool expandedText;



  HomeUserMenuButton({
    super.key, 
    this.text,
    required this.onPressed,
    this.backgroundColor = AppColors.primaryColor, 
    TextStyle? textStyle,
    this.enabledBorder = false,
    this.svgIcon,
    this.expandedText = false
  }) : textStyle = textStyle ?? AppTextStyles.builder(color: AppColors.ateneaWhite, size: FontSizes.h4); // Lo hacemos aquí.


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        side: enabledBorder  // Condicional para mostrar borde solo si `hasBorder` es `true`
              ? const BorderSide(
                  color: AppColors.primaryColor,  // Color del borde
                  width: 1.5,  // Grosor del borde
                  style: BorderStyle.solid,  // Estilo sólido
                )
              : BorderSide.none, 
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          if (text != null) 
          Text(
            text!,
            style: textStyle,
          ),

          

          if (svgIcon != null)
            Padding(
              padding: EdgeInsets.only(left: text != null ? 8.0 : 0.0),
              child: SvgPicture.asset(
                svgIcon!,
                height: iconSize,
                width: iconSize,
              ),
            ),
        ],
      ),
    );
  }
}
