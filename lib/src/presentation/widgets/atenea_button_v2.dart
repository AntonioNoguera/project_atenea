//Better Versión of AteneaButton
//First dart proyect lmao
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart'; 

class SvgButton {
  final String svgPath;
  final double svgDimentions;
  final Color svgTint;

  SvgButton({
    required this.svgPath, 
    required this.svgDimentions,
    required this.svgTint
    }
  );
}
