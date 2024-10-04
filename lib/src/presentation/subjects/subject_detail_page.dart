import 'package:flutter/material.dart';
import 'package:proyect_atenea/src/presentation/subjects/widgets/theme_or_file_subject.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_scaffold.dart';

class SubjectDetailPage extends StatelessWidget {
  const SubjectDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AteneaScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: 50.0,
        ),
        child: Column(
          children: [
            Text(
              'Nombre de la Materia Genérica',
              textAlign: TextAlign.center,
              style: AppTextStyles.builder(
                color: AppColors.primaryColor,
                size: FontSizes.h3,
                weight: FontWeights.semibold,
              ),
            ),
            const SizedBox(height: 10),

            // Aquí comienza el contenido desplazable
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    
                    const Card(
                      child: Column(
                        children: [
                          Text('Capturado por:'),
                          Text('Michael Antonio Noguera Guzmán'),
                          SizedBox(height: 20),
                          Text('Actualizado en:'),
                          Text('23 Sep 2024 + 15:20'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    Row(
                      children: [
                        Expanded(
                          child: AteneaButton(
                            text: 'Temas',
                            textStyle: AppTextStyles.builder(
                              size: FontSizes.body2,
                              color: AppColors.ateneaWhite,
                            ),
                            onPressed: () {
                              // Acción para 'Temas'
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: AteneaButton(
                            text: 'Recursos',
                            textStyle: AppTextStyles.builder(
                              size: FontSizes.body2,
                              color: AppColors.ateneaWhite,
                            ),
                            onPressed: () {
                              // Acción para 'Recursos'
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Contenido dentro de ThemeOrFileSubject
                    ThemeOrFileSubject(
                      contentType: 'Contenido del tema',
                    ),
                  ],
                ),
              ),
            ),
            // Fin del contenido desplazable

            const SizedBox(height: 20.0),

            // Aquí está el row de botones que no debe estar en el scroll
            Row(
              children: [
                AteneaButton(
                  text: 'Volver',
                  backgroundColor: AppColors.secondaryColor,
                  onPressed: () {
                    print("PressedBack");
                  },
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: AteneaButton(
                    text: 'Marcar como favorito',
                    onPressed: () {
                      print("PressedFavorite");
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
