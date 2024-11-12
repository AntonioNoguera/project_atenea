//Better Versión of AteneaButton
//First dart proyect lmao
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart'; 

class SvgButtonStyle {
  final String svgPath;
  final double svgDimentions; 

  SvgButtonStyle({
    required this.svgPath, 
    this.svgDimentions = 30, 
    }
  );
}

class AteneaButtonV2 extends StatelessWidget {

  final String? text;

  final TextStyle textStyle; 

  final VoidCallback? onPressed; 
  
  final AteneaButtonStyles btnStyles;
  
  final SvgButtonStyle? svgIcon;              

  final bool xpndText;

  final EdgeInsets padding;
  
  const AteneaButtonV2({
    super.key, 
    this.text,
    this.onPressed, 
    this.textStyle = const TextStyle(
      fontFamily: 'RadioCanada',
      color: AppColors.ateneaWhite,
      fontSize: FontSizes.h5,
      fontWeight: FontWeights.regular,
    ),
    this.btnStyles = const AteneaButtonStyles(
      backgroundColor: AppColors.primaryColor,
      textColor: AppColors.ateneaWhite,
    ),
    this.svgIcon,
    this.xpndText = false,
    this.padding = const EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: btnStyles.backgroundColor,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 12.0,
        shadowColor: Colors.black.withOpacity(0.5),
        side: btnStyles.hasBorder ? BorderSide(
                  color: btnStyles.textColor,
                  width: 1.5,
                  style: BorderStyle.solid,
                ) : BorderSide.none, 
      ),
      onPressed: onPressed,
      child: Row( 
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          if (text != null) 
            Text(
              text!,
              style: textStyle,
            ), 
          
          if (xpndText)
            const Spacer(),
          
          if (svgIcon != null)
            Padding(
              padding: EdgeInsets.only(left: text != null ? 8.0 : 0.0),
              child: SvgPicture.asset(
                svgIcon!.svgPath,
                height: svgIcon!.svgDimentions,
                width: svgIcon!.svgDimentions,
                color: btnStyles.textColor,
              ),
            ),
        ],
      ),
    );
  }
}