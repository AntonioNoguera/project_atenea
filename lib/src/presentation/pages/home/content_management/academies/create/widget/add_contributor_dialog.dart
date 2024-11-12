import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_atenea/src/presentation/providers/app_state_providers/active_index_notifier.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_checkbox_button.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_field.dart';

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

                const SizedBox(height: 10,),

                const AteneaField(
                  placeHolder: 'Nuevo Nombre',
                  inputNameText: 'Matrícula',
                ), 

                const SizedBox(height: 10,),
                
                Text(
                  textAlign: TextAlign.center,
                  '¿Qué permisos tendrá el nuevo contribuidor?',
                  style: AppTextStyles.builder(
                    color: AppColors.primaryColor.withOpacity(0.85),
                    size: FontSizes.body2,
                  )
                ),

                const SizedBox(height: 10,),

                Row(
                  children: [
                     
                    
                    Expanded(
                      child : AteneaCheckboxButton(
                        checkboxText: 'Modificar Contenidos',
                        initialState: true, 
                        onChanged: (value) {
                          print('Esta seleccionado: $value');
                        },
                      ), 
                    ),
                  ],
                ),

                  
                const SizedBox(height: 5,),

                AteneaCheckboxButton(
                    checkboxText: 'Añadir nuevos contribuidores',
                    initialState: true, 
                    onChanged: (value) {
                      print('Esta seleccionado: $value');
                    },
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
            buttonStyles: const AteneaButtonStyles(
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