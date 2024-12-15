import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:proyect_atenea/src/domain/entities/file_entity.dart';
import 'package:proyect_atenea/src/presentation/providers/app_state_providers/active_index_notifier.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button_column.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button_v2.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_card.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_circular_progress.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_field.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart';

class AddFileDialog extends StatefulWidget {

  final void Function(FileEntity, List<int>) onFileAdded;
  const AddFileDialog({super.key, required this.onFileAdded});

  @override
  _AddFileDialogState createState() => _AddFileDialogState();
}

class _AddFileDialogState extends State<AddFileDialog> {
  TextEditingController _fileNameController = TextEditingController();
  PlatformFile? _selectedFile;
  bool _isLoading = false; // Nueva variable para controlar el estado de carga

  Future<void> _pickFile() async {
    setState(() {
      _isLoading = true; // Inicia el estado de carga
    });

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(withData: true);

      if (result != null) {
        setState(() {
          _selectedFile = result.files.first;
          // Tomar unicamente los primeros 30 caracteres del nombre del archivo
          _fileNameController.text = _selectedFile!.name.length > 30
              ? '${_selectedFile!.name.substring(0, 30)}...'
              : _selectedFile!.name;
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
    } finally {
      setState(() {
        _isLoading = false; // Finaliza el estado de carga
      });
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
                const SizedBox(height: 10),
                AteneaField(
                  placeHolder: 'Ej. Introducción a la programación',
                  inputNameText: 'Nombre del archivo',
                  controller: _fileNameController,
                ),
                const SizedBox(height: 20),
 
                if (_isLoading)
                  const Center(
                    child: AteneaCircularProgress() 
                  )
                else if (_selectedFile == null)
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
                  _selectedFile!.bytes != null &&
                  _fileNameController.text.trim().isNotEmpty) {
                final fileEntity = FileEntity(
                  name: _fileNameController.text,
                  extension: _selectedFile!.extension ?? 'unknown',
                  size: _selectedFile!.size,
                  downloadUrl: '',
                  subjectId: 'widget.subjectId,',
                  uploadedAt: DateTime.now().toIso8601String(),
                );

                widget.onFileAdded(fileEntity, _selectedFile!.bytes!);
                Navigator.of(context).pop();
              } else {
                print('Error: No se ha seleccionado un archivo o el nombre está vacío.');
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
      child: Column(
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
          Text(
            _selectedFile!.name,
            style: AppTextStyles.builder(
              color: AppColors.primaryColor.withOpacity(.8),
              size: FontSizes.body3,
              weight: FontWeights.regular,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Tipo de Archivo: ',
                        style: AppTextStyles.builder(
                          color: AppColors.textColor,
                          size: FontSizes.body2,
                          weight: FontWeights.semibold,
                        ),
                        children: [
                          TextSpan(
                            text: _selectedFile!.extension ?? 'Desconocido',
                            style: AppTextStyles.builder(
                              color: AppColors.textColor,
                              size: FontSizes.body2,
                              weight: FontWeights.regular,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    RichText(
                      text: TextSpan(
                        text: 'Tamaño: ',
                        style: AppTextStyles.builder(
                          color: AppColors.textColor,
                          size: FontSizes.body2,
                          weight: FontWeights.semibold,
                        ),
                        children: [
                          TextSpan(
                            text:
                                '${(_selectedFile!.size / 1024).toStringAsFixed(2)} KB',
                            style: AppTextStyles.builder(
                              color: AppColors.textColor,
                              size: FontSizes.body2,
                              weight: FontWeights.regular,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: AteneaButtonColumn(
                  padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 10.0),
                  text: 'Cambiar Archivo',
                  textStyle: AppTextStyles.builder(
                    color: AppColors.ateneaWhite,
                    size: FontSizes.body4,
                    weight: FontWeights.regular,
                  ),
                  btnStyles: AteneaButtonStyles(
                    backgroundColor:
                        AppColors.heavyPrimaryColor.withOpacity(.8),
                    textColor: AppColors.ateneaWhite,
                  ),
                  svgIcon: SvgButtonStyle(
                    svgPath: 'assets/svg/replace.svg',
                    svgDimentions: 35.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
