import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_atenea/src/presentation/providers/app_state_providers/active_index_notifier.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_field.dart';
import 'package:proyect_atenea/src/presentation/widgets/toggle_buttons_widget%20.dart';

class AddThemeDialog extends StatelessWidget {
  const AddThemeDialog ({super.key});

  void _handleToggle(int index) {
    // Maneja el cambio de índice aquí
    print(index.toString());
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ActiveIndexNotifier(),
      child: AteneaDialog(
        title: 'Añade Nuevo Tema',
        content: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 1000,
            maxHeight: 600, // Limita la altura máxima a 300
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Un tema es una unidad de contenido que se puede agregar a una materia, no te preocupes por el orden, puedes reordenarlos después.',
                  style: AppTextStyles.builder(
                    color: AppColors.primaryColor.withOpacity(0.7),
                    size: FontSizes.body2,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 10,),

                const AteneaField(
                  placeHolder: 'Nombre del Tema',
                  inputNameText: 'Nombre del tema',
                ), 

                SizedBox(height: 20,),
                Text(
                  'Esta unidad temática corresponde a',
                  style: AppTextStyles.builder(
                    color: AppColors.primaryColor.withOpacity(0.7),
                    size: FontSizes.body2,
                  ),
                  textAlign: TextAlign.center,
                ),
                ToggleButtonsWidget(
                  onToggle: _handleToggle,
                  toggleOptions: ['Medio Curso', 'Ordinario'],
                ),
 

              ],
            ),
          ),
        ),
        buttonCallbacks: [
          AteneaButtonCallback(
            textButton: 'Cancelar',
            onPressedCallback: () {
              Navigator.of(context).pop();
            },
            buttonStyles: AteneaButtonStyles(
              backgroundColor: AppColors.secondaryColor,
              textColor: AppColors.ateneaWhite,
            ),
          ),
          AteneaButtonCallback(
            textButton: 'Aceptar',
            onPressedCallback: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}