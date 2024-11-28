import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_atenea/src/presentation/pages/home/home_page.dart';
import 'package:proyect_atenea/src/presentation/providers/app_state_providers/active_index_notifier.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button_v2.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_card.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_field.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_page_animator.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_scaffold.dart';
import 'package:proyect_atenea/src/presentation/widgets/toggle_buttons_widget%20.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({
    super.key,
  });

  void _handleToggle(BuildContext context, int index) {
    Provider.of<ActiveIndexNotifier>(context, listen: false)
        .setActiveIndex(index);
  }

  Widget _renderedContent(int activeIndex) {
    final Map<int, Widget> renderedContent = {
      0: Column(
        children: [
          AteneaCard(
            child: Column(
              children: [
                Text(
                  'Atención',
                  style: AppTextStyles.builder(
                    color: AppColors.ateneaBlack,
                    size: FontSizes.h5,
                    weight: FontWeights.bold,
                  ),),
                Text(
                  'Una vez realizado el registro, deberás de solicitar a un adminsitrador que te asigne un permiso de cualquier tipo de entidad para poder continuar.',
                  style: AppTextStyles.builder(
                    color: AppColors.textColor,
                    size: FontSizes.body2,
                    weight: FontWeights.regular,
                  ),
                  textAlign: TextAlign.center,
                  ),
              ],
            )
          ),

          const SizedBox(height: 15),

          Text(
            'Registro de Docente',
            textAlign: TextAlign.center,
            style: AppTextStyles.builder(
              color: AppColors.primaryColor,
              size: FontSizes.h5,
              weight: FontWeights.bold,
            ),
          ),

          const SizedBox(height: 10),
          Row(
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
            inputNameText: 'Contraseña',

              isPasswordField: true,
          ),
          const SizedBox(height: 10),
          const AteneaField(
            placeHolder: 'Ejemplo: Fernando',
            inputNameText: 'Verificar Contraseña',

              isPasswordField: true,
          ),
          const SizedBox(height: 30),
        ],
      ),
      1: Column(
        children: [
          
          const SizedBox(height: 5),

          Text(
            'Registro de Estudiante',
            textAlign: TextAlign.center,
            style: AppTextStyles.builder(
              color: AppColors.primaryColor,
              size: FontSizes.h5,
              weight: FontWeights.bold,
            ),
          ),

          const SizedBox(height: 10),
          const AteneaField(
            placeHolder: 'Ejemplo: 2977400',
            inputNameText: 'Matrícula',
          ),
          const SizedBox(height: 10),
          const AteneaField(
            placeHolder: 'Ejemplo: Fernando',
            inputNameText: 'Contraseña',

              isPasswordField: true,
          ),
          const SizedBox(height: 10),
          const AteneaField(
            placeHolder: 'Ejemplo: Fernando',
            inputNameText: 'Verificar Contraseña',

              isPasswordField: true,
          ),
          const SizedBox(height: 30),
        ],
      ),
    };

    return renderedContent[activeIndex] ?? const Text('Unrenderable');
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ActiveIndexNotifier(),
      child: Consumer<ActiveIndexNotifier>(
        builder: (context, activeIndexNotifier, child) {
          return AteneaScaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
                vertical: 30.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // El título es estático, no se desplazará
                  Text(
                    'Registrarme como:',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.builder(
                      color: AppColors.primaryColor,
                      size: FontSizes.h3,
                      weight: FontWeights.bold,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  // El contenido desplazable
                  ToggleButtonsWidget(
                    onToggle: (index) => _handleToggle(context, index),
                    toggleOptions: const ['Docente', 'Estudiante'],
                  ),

                  const SizedBox(height: 20.0),

                  Expanded(
                    child: SingleChildScrollView(
                      child: _renderedContent(activeIndexNotifier.activeIndex),
                    ),
                  ),

                  Row(
                    children: [
                      AteneaButtonV2(
                        text: 'Regresar', 
                        btnStyles: const AteneaButtonStyles(
                          backgroundColor: AppColors.secondaryColor,
                          textColor: AppColors.ateneaWhite, 
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: AteneaButtonV2(
                          text: 'Registrate',
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              AteneaPageAnimator(page: const HomePage()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
