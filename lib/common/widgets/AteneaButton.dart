import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AteneaButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor; 
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final TextStyle? textStyle;
  final String? svgIcon; // Path al recurso SVG
  final double? iconSize; // Tamaño opcional del ícono

  const AteneaButton({super.key, 
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.blue, 
    this.borderRadius = 10.0,
    this.padding = const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
    this.textStyle,
    this.svgIcon, // añadir esto
    this.iconSize = 24.0, // añadir esto, default 24
  });

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
        mainAxisSize: MainAxisSize.min, // Asegura que el Row no ocupe todo el botón innecesariamente
        children: [  // Si hay un ícono SVG, mostrarlo
            Padding(
              padding: const EdgeInsets.only(right: 8.0), // Añade espacio entre el ícono y el texto
              child: SvgPicture.asset(
                'assets/svg/Historial.svg',
                height: 80.0,
                width: 80.0,
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
