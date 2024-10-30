import 'package:flutter/material.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button_v2.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_field.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_scaffold.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AteneaScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: 50.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // El título es estático, no se desplazará
            Text(
              'Registro',
              textAlign: TextAlign.center,
              style: AppTextStyles.builder(
                color: AppColors.primaryColor,
                size: FontSizes.h1,
                weight: FontWeights.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            // El contenido desplazable
            Expanded(
              // Esto asegura que el contenido puede desplazarse
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Estos datos se usarán únicamente para estadística',
                      style: AppTextStyles.builder(
                        color: AppColors.secondaryColor,
                        size: FontSizes.body1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20.0), // Espaciado
                    // Botones de selección
                    /*
                    Row(
                      children: [
                        Flexible(
                          child: AteneaButton(
                            text: 'Soy Estudiante',
                            backgroundColor: AppColors.primaryColor,
                            textStyle: const TextStyle(
                              color: AppColors.ateneaWhite,
                              fontSize: FontSizes.body1,
                            ),
                            onPressed: () {},
                          ),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: AteneaButton(
                            text: 'Soy Docente',
                            enabledBorder: true,
                            textStyle: const TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: FontSizes.body1,
                            ),
                            backgroundColor: AppColors.ateneaWhite,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),

                  */
                    const SizedBox(height: 10.0),
                    // Campos de texto
                    const AteneaField(
                      placeHolder: 'Ejemplo: Fernando',
                      inputNameText: 'Matrícula',
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      children: [
                        Flexible(
                          child: AteneaField(
                            placeHolder: 'Ejemplo: Fernando',
                            inputNameText: 'Nombre (s)',
                          ),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: AteneaField(
                            placeHolder: 'Ejemplo: Fernando',
                            inputNameText: 'Apellidos',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const AteneaField(
                      placeHolder: 'Ejemplo: Fernando',
                      inputNameText: 'Correo Electrónico',
                    ),
                    const SizedBox(height: 10),
                    const AteneaField(
                      placeHolder: 'Ejemplo: Fernando',
                      inputNameText: 'Tipo de permiso',
                    ),
                    const SizedBox(height: 10),
                    const AteneaField(
                      placeHolder: 'Ejemplo: Fernando',
                      inputNameText: 'Departamento / Académica',
                    ),
                    const SizedBox(height: 10),
                    const AteneaField(
                      placeHolder: 'Ejemplo: Fernando',
                      inputNameText: 'Contraseña',
                    ),
                    const SizedBox(height: 10),
                    const AteneaField(
                      placeHolder: 'Ejemplo: Fernando',
                      inputNameText: 'Verificar Contraseña',
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            // Botones en la parte inferior, fuera del scroll
            Row(
              children: [
                AteneaButtonV2(

                  svgIcon : SvgButtonStyle(
                    svgPath: 'assets/svg/back_action.svg', 
                    svgDimentions: 30,
                  ),

                  btnStyles: const AteneaButtonStyles(
                    backgroundColor: AppColors.secondaryColor, 
                    textColor: AppColors.ateneaWhite,
                    hasBorder : true,
                  ),
                  onPressed: () {},
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: AteneaButtonV2(
                    text: 'Registrar',
                    onPressed: () {},
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
