import 'package:flutter/material.dart';
import 'package:proyect_atenea/src/presentation/subjects/widgets/theme_or_file_subject.dart'; // Asegúrate de importar el nuevo widget
import 'package:proyect_atenea/src/presentation/subjects/widgets/toggle_buttons_widget%20.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_scaffold.dart';

class SubjectDetailPage extends StatelessWidget {
  const SubjectDetailPage({super.key});

   void _handleToggle(int activeIndex) {
    // Aquí ejecutas el código que desees al cambiar el valor de activeIndex
    if (activeIndex == 0) {
      print("El botón 'Temas' está activo");
      // Código para cuando 'Temas' está activo
    } else {
      print("El botón 'Recursos' está activo");
      // Código para cuando 'Recursos' está activo
    }
  }

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
            
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center, // Centra horizontalmente los hijos del Column
                          children: [
                            Text(
                              'Redactado por:',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.builder(
                                color: AppColors.ateneaBlack,
                                size: FontSizes.body1,
                                weight: FontWeights.semibold,
                              ),
                            ),

                            Text(
                              'Michael Antonio Noguera Guzmán',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.builder(
                                color: AppColors.grayColor,
                                size: FontSizes.body2,
                                weight: FontWeights.regular,
                              ),
                            ),

                            const SizedBox(height: 20),

                            Text(
                              'Última Actualización:',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.builder(
                                color: AppColors.ateneaBlack,
                                size: FontSizes.body1,
                                weight: FontWeights.semibold,
                              ),
                            ),

                            Text(
                              '23 Sep 2024 | 15:20',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.builder(
                                color: AppColors.grayColor,
                                size: FontSizes.body2,
                                weight: FontWeights.regular,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // El nuevo widget ToggleButtonsWidget maneja su propio estado 
                    ToggleButtonsWidget(
                      onToggle: _handleToggle,  // Aquí pasamos la función que manejará el cambio
                    ),

                    const SizedBox(height: 10),
 
                    Column(
                      children: List.generate(2, (index) {
                        return ThemeOrFileSubject(
                          contentType: 'Contenido del tema',
                          hasSvg: index == 1,
                        );
                      }),
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
                    text: 'Marcar ',
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
