import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_atenea/src/presentation/providers/app_state_providers/active_index_notifier.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_field.dart';
import 'package:proyect_atenea/src/presentation/widgets/toggle_buttons_widget%20.dart';

class AddThemeDialog extends StatefulWidget {
  final Function(String themeName, String type) onAddTheme;
  final String previousSemesterStage;
  final List<String> toggleOptions = const ['Medio Curso', 'Ordinario'];

  const AddThemeDialog({
    super.key, 
    required this.onAddTheme, 
    required this.previousSemesterStage
  });

  @override
  State<AddThemeDialog> createState() => _AddThemeDialogState();
}

class _AddThemeDialogState extends State<AddThemeDialog> {
  final TextEditingController _themeNameController = TextEditingController();
  int _activeIndex = 0; // 0 = Medio Curso, 1 = Ordinario

  @override
  void dispose() {
    _themeNameController.dispose();
    super.dispose();
  }

  void _handleToggle(int index) {
    setState(() {
      _activeIndex = index;
    });
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
            maxHeight: 600,
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
                const SizedBox(height: 10),
                AteneaField(
                  placeHolder: 'Nombre del Tema',
                  inputNameText: 'Nombre del tema',
                  controller: _themeNameController,
                ),
                const SizedBox(height: 20),
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
                  toggleOptions: widget.toggleOptions,
                  previousOptionSelected: widget.previousSemesterStage,
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
              final themeName = _themeNameController.text.trim();
              if (themeName.isNotEmpty) {
                final type = widget.toggleOptions[_activeIndex];
                widget.onAddTheme(themeName, type);
                Navigator.of(context).pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('El nombre del tema no puede estar vacío')),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
