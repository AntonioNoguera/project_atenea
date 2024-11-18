import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart';

class SvgButtonStyle {
  final String svgPath;
  final double svgDimentions;

  SvgButtonStyle({
    required this.svgPath,
    this.svgDimentions = 30,
  });
}

class AteneaButtonV2 extends StatefulWidget {
  final String? text;
  final TextStyle textStyle;
  final VoidCallback? onPressed;
  final AteneaButtonStyles btnStyles;
  final SvgButtonStyle? svgIcon;
  final bool xpndText;
  final EdgeInsets padding;

  /// Propiedad para decidir si el botón debe entrar en estado de carga
  final bool shouldLoad;

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
    this.shouldLoad = false, // Controla si se permite el estado de carga
  });

  @override
  State<AteneaButtonV2> createState() => _AteneaButtonV2State();
}

class _AteneaButtonV2State extends State<AteneaButtonV2> {
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
          ? () {} // Deshabilita el botón mientras está cargando
          : () {
              if (widget.onPressed != null) {
                _startLoading(); // Cambia el estado a "cargando"
                widget.onPressed!();
                // Simula finalización de la tarea después de 2 segundos
                Future.delayed(const Duration(seconds: 2), _stopLoading);
              }
            },
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Contenido normal del botón
          if (!isLoading)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.text != null)
                  Text(
                    widget.text!,
                    style: widget.textStyle,
                  ),
                if (widget.xpndText) const Spacer(),
                if (widget.svgIcon != null)
                  Padding(
                    padding: EdgeInsets.only(left: widget.text != null ? 8.0 : 0.0),
                    child: SvgPicture.asset(
                      widget.svgIcon!.svgPath,
                      height: widget.svgIcon!.svgDimentions,
                      width: widget.svgIcon!.svgDimentions,
                      color: widget.btnStyles.textColor,
                    ),
                  ),
              ],
            ),
          // Indicador de carga con espaciado vertical
          if (isLoading)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0), // Espaciado vertical
              child: SizedBox(
                height: 20, // Tamaño fijo del CircularProgressIndicator
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
