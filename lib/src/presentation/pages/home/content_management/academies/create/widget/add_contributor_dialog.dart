import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_atenea/src/presentation/providers/app_state_providers/active_index_notifier.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_checkbox_button.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_field.dart';
import 'package:proyect_atenea/src/presentation/widgets/toggle_buttons_widget%20.dart';

class AddContributorDialog extends StatelessWidget {
  const AddContributorDialog({super.key});

  void _handleToggle(int index) {
    // Maneja el cambio de índice aquí
    print(index.toString());
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ActiveIndexNotifier(),
      child: AteneaDialog(
        title: 'Añade Contribuidor',
        content: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 600,
            maxHeight: 600, // Limita la altura máxima a 300
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Busca contribuidores',
                  style: AppTextStyles.builder(
                    color: AppColors.secondaryColor,
                    size: FontSizes.body1,
                  ),
                ),

                SizedBox(height: 10,),

                const AteneaField(
                  placeHolder: 'Nuevo Nombre',
                  inputNameText: 'Matrícula',
                ), 

                SizedBox(height: 10,),
                
                AteneaCheckboxButton(
                  initialState: true, 
                  onChanged: (value) {
                    print("Esta seleccionado: " + value.toString());
                  },
                  )

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