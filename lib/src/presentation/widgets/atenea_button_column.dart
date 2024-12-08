import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button_v2.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart';


class AteneaButtonColumn extends StatefulWidget {
  final String? text;
  final TextStyle textStyle;
  final VoidCallback? onPressed;
  final AteneaButtonStyles btnStyles;
  final SvgButtonStyle? svgIcon;
  final EdgeInsets padding;
  final bool shouldLoad;

  const AteneaButtonColumn({
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
    this.padding = const EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
    this.shouldLoad = false, // Controla si se permite el estado de carga
  });

  @override
  State<AteneaButtonColumn> createState() => _AteneaButtonColumnState();
}

class _AteneaButtonColumnState extends State<AteneaButtonColumn> {
  bool isLoading = false; // Estado interno para determinar si está cargando

  void _startLoading() {
    if (widget.shouldLoad) {
      setState(() {
        isLoading = true;
      });
    }
  }

  void _stopLoading() {
    if (widget.shouldLoad) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.btnStyles.backgroundColor,
        padding: widget.padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 12.0,
        shadowColor: Colors.black.withOpacity(0.5),
        side: widget.btnStyles.hasBorder
            ? BorderSide(
                color: widget.btnStyles.textColor,
                width: 1.5,
                style: BorderStyle.solid,
              )
            : BorderSide.none,
      ),
      onPressed: isLoading
          ? null
          : () {
              if (widget.onPressed != null) {
                _startLoading();
                widget.onPressed!();
                Future.delayed(const Duration(seconds: 10), _stopLoading);
              }
            },
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (!isLoading)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 
                if (widget.svgIcon != null)
                  SvgPicture.asset(
                    widget.svgIcon!.svgPath,
                    height: widget.svgIcon!.svgDimentions,
                    width: widget.svgIcon!.svgDimentions,
                    color: widget.btnStyles.textColor,
                  ),
                

                if (widget.text != null)
                  Text(
                    widget.text!,
                    style: widget.textStyle,
                  ),
              ],
            ),
          if (isLoading)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      widget.textStyle.color ?? widget.btnStyles.textColor),
                  strokeWidth: 2.5,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
