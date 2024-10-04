import 'package:flutter/material.dart';
import 'package:proyect_atenea/src/presentation/subjects/widgets/member_row.dart';

class ThemeOrFileSubject extends StatelessWidget {
  final String contentType;

  const ThemeOrFileSubject({
    super.key,
    this.contentType = '',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(contentType),
        const SizedBox(height: 10),
        Column(
          children: List.generate(12, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0), // Añade espaciado vertical
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Puedes ajustar el color de fondo si lo deseas
                  borderRadius: BorderRadius.circular(10.0), // Borde redondeado de 10 píxeles
                ),
                padding: const EdgeInsets.all(12.0), // Espacio interno del contenedor
                child: MemberRow(contentType: 'Item $index'), // Pasamos el índice al MemberRow
              ),
            );
          }),
        ),
      ],
    );
  }
}
