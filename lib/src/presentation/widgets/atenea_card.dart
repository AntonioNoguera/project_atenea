import 'package:flutter/material.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';

class AteneaCard extends StatelessWidget {
  final Widget child;

  AteneaCard({
    super.key, 
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Hace que el Card abarque el ancho máximo disponible
      child: Card(
        elevation: 10, // Sombras
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Bordes redondeados
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              child,
            ],
          ),
        ),
      ),
    );
  }
}
