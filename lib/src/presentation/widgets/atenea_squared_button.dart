import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';

class Ateneasquaredbutton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final TextStyle? textStyle;
  final String? svgIcon;
  // Constant data of the button
  final double borderRadius = 10.0;
  final double iconSize = 35.0;
  final EdgeInsetsGeometry padding = const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0);

  Ateneasquaredbutton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = AppColors.primaryColor,
    TextStyle? textStyle,
    this.svgIcon,
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
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (svgIcon != null)
            Expanded(
              flex: 3, // Proporciona más espacio al SVG
              child: SvgPicture.asset(
                svgIcon!,
                fit: BoxFit.contain,
              ),
            ),
          Text(
            text,
            style: textStyle,
          ),
        ],
      ),
    );
  }
}
