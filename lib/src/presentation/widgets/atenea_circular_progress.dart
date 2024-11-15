import 'package:flutter/material.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';

class AteneaCircularProgress extends StatelessWidget {
  final Color componentColor;

  const AteneaCircularProgress({super.key, this.componentColor = AppColors.primaryColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Centrar contenido verticalmente
        children: [
          Text(
            'Cargando...',
            style: AppTextStyles.builder(
              color: componentColor,
              size: 20.0,
              weight: FontWeights.semibold,
            ),
          ),
          const SizedBox(height: 10), // Espaciado entre el texto y el indicador
          CircularProgressIndicator(color: componentColor),
        ],
      ),
    );
  }
}
