import 'package:flutter/material.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart';

class DeleteSubjectContentDialog extends StatelessWidget {
  final String itemText;
  final VoidCallback onDelete;

  const DeleteSubjectContentDialog({
    super.key,
    required this.itemText,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) { 

    return AteneaDialog(
      title: 'Eliminar Tema',
      content: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: AppTextStyles.builder(
            size: FontSizes.body2,
            weight: FontWeights.regular,
            color: AppColors.textColor,
          ),
          children: [
            const TextSpan(text: '¿Estás seguro de que quieres eliminar '),
            TextSpan(
              text: itemText,
              style: AppTextStyles.builder(
                size: FontSizes.body2,
                weight: FontWeights.semibold,
                color: AppColors.primaryColor,
              ),
            ),
            const TextSpan(text: '?, esta acción se ejecutará hasta que presiones el botón '),
            TextSpan(
              text: '"Guardar Cambios"',
              style: AppTextStyles.builder(
                size: FontSizes.body2,
                weight: FontWeights.semibold,
                color: AppColors.primaryColor,
              ),
            ),
            const TextSpan(text: '.'),
          ],
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
             onDelete();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
