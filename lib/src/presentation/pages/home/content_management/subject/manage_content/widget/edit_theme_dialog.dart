import 'package:flutter/material.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_field.dart';

class EditThemeDialog  extends StatelessWidget {
  final String currentText;
  final Function(String newText) onSave;

  const EditThemeDialog ({
    super.key,
    required this.currentText,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController(text: currentText);
    
    return AteneaDialog(
      title: 'Editar Tema',
      content: AteneaField(
        inputNameText: 'Nombre del Tema',
        placeHolder: 'ej. Tema 1',
        controller: controller, 
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
          textButton: 'Guardar',
          onPressedCallback: () {
            final newText = controller.text.trim();
            if (newText.isNotEmpty) {
              onSave(newText);
              Navigator.of(context).pop();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('El texto no puede estar vacío')),
              );
            }
          },
        ),
      ],
    );
  }
}
