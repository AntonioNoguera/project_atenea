import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:proyect_atenea/src/presentation/providers/app_state_providers/active_index_notifier.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_field.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart';

class AddFileDialog extends StatelessWidget {
  const AddFileDialog({super.key});

  Future<void> _pickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;
      print('File name: ${file.name}');
      print('File size: ${file.size}');
      if (file.bytes != null) {
        print('File bytes length: ${file.bytes!.length}');
      } else {
        print('File path: ${file.path}');
      }
      // Puedes manejar el archivo seleccionado aquí
    } else {
      // El usuario canceló la selección del archivo
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ActiveIndexNotifier(),
      child: AteneaDialog(
        title: 'Añade Nuevo Archivo',
        content: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 1000,
            maxHeight: 600, // Limita la altura máxima a 600
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Nombra tu archivo',
                  style: AppTextStyles.builder(
                    color: AppColors.primaryColor.withOpacity(0.7),
                    size: FontSizes.body2,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const AteneaField(
                  placeHolder: 'Nombre del Tema',
                  inputNameText: 'Nombre del tema',
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _pickFile(context),
                  child: const Text('Seleccionar Archivo'),
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
          ),
          AteneaButtonCallback(
            textButton: 'Aceptar',
            onPressedCallback: () {
              // Lógica para manejar la aceptación del archivo
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}