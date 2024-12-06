import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:proyect_atenea/src/presentation/providers/app_state_providers/active_index_notifier.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button_v2.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_card.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_field.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart';

class AddFileDialog extends StatefulWidget {
  const AddFileDialog({super.key});

  @override
  _AddFileDialogState createState() => _AddFileDialogState();
}

class _AddFileDialogState extends State<AddFileDialog> {
  final TextEditingController _fileNameController = TextEditingController();
  PlatformFile? _selectedFile;

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        setState(() {
          _selectedFile = result.files.first;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error al seleccionar el archivo: $e',
            style: AppTextStyles.builder(
              color: AppColors.ateneaWhite,
              size: FontSizes.body2,
            ),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _fileNameController.dispose();
    super.dispose();
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
            maxHeight: 600,
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
                AteneaField(
                  placeHolder: 'Ej. Introducción a la programación',
                  inputNameText: 'Nombre del archivo',
                  controller: _fileNameController,
                ),
                const SizedBox(height: 20),

                if (_selectedFile == null)
                   AteneaButtonV2(
                    onPressed: _pickFile,
                    text: 'Seleccionar Archivo',
                    svgIcon: SvgButtonStyle(
                      svgPath: 'assets/svg/add.svg',
                      svgDimentions: 20.0,
                    ),
                    textStyle: AppTextStyles.builder(
                      size: FontSizes.body1,
                      color: AppColors.ateneaWhite,
                      weight: FontWeights.regular,
                    ),
                  ),  
                 
                if (_selectedFile != null) _buildFileInfo(),
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
              if (_selectedFile != null &&
                  _fileNameController.text.trim().isNotEmpty) {
                // Lógica para manejar el archivo y su contenido
                print('Archivo aceptado: ${_selectedFile!.name}');
                Navigator.of(context).pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Por favor selecciona un archivo y proporciona un nombre.',
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFileInfo() {
  return AteneaCard(
    child : Column(
      children: [ 
        Text(
          'Archivo Seleccionado',
          style: AppTextStyles.builder(
            color: AppColors.primaryColor,
            size: FontSizes.body1,
            weight: FontWeights.semibold,
          ),
          textAlign: TextAlign.center,
        ),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Información del archivo
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Alinea los textos al inicio
                children: [
                  Text(
                    'Nombre:\n${_selectedFile!.name}',
                    style: AppTextStyles.builder(
                      color: AppColors.textColor,
                      size: FontSizes.body2,
                      weight: FontWeights.regular,
                    ),
                  ),
                  const SizedBox(height: 4.0), // Espaciado entre textos
                  Text(
                    'Tamaño: ${(_selectedFile!.size / 1024).toStringAsFixed(2)} KB',
                    style: AppTextStyles.builder(
                      color: AppColors.textColor,
                      size: FontSizes.body2,
                      weight: FontWeights.regular,
                    ),
                  ),
                  const SizedBox(height: 4.0), // Espaciado entre textos
                  if (_selectedFile!.bytes != null)
                    Text(
                      'Contenido: ${_selectedFile!.bytes!.length} bytes',
                      style: AppTextStyles.builder(
                        color: AppColors.textColor,
                        size: FontSizes.body2,
                        weight: FontWeights.regular,
                      ),
                    ),
                ],
              ),
            ),
            // Botón de acción para cambiar el archivo
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: AteneaButtonV2(
                btnStyles: const AteneaButtonStyles(
                  backgroundColor: AppColors.ateneaWhite,
                  textColor: AppColors.ateneaBlack,
                ),
                svgIcon: SvgButtonStyle(
                  svgPath: 'assets/svg/add.svg',
                  svgDimentions: 35.0,
                ),
              ),
            ),
          ],
        ),
      ]
    )
  );
}


}
