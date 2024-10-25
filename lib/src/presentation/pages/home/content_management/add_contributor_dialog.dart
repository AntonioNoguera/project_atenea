
import 'package:flutter/material.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_field.dart';

class AddContributorDialog extends StatelessWidget {
  const AddContributorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AteneaDialog(
      title: 'Añade Contribuidor',
      content: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 600,
          maxHeight: 150.0,
        ),
        child: const Column (
          children: [

            Text('Busca contribuidores'),   

            AteneaField(
              placeHolder: 'Nuevo Nombre',
              inputNameText: 'Nombres',
            ),
          ],
        ),
      ),  

      buttonCallbacks: [
        AteneaButtonCallback(
          textButton:'Cancelar',
          onPressedCallback: () {  
            Navigator.of(context).pop();
          },
          
          buttonStyles: AteneaButtonStyles(
            backgroundColor: AppColors.secondaryColor, 
            textColor: AppColors.ateneaWhite
          )
        ),
        AteneaButtonCallback(
          textButton:'Aceptar',
          onPressedCallback: () {  
            Navigator.of(context).pop();
          }
        ),
      ],
    );
  }
}
 