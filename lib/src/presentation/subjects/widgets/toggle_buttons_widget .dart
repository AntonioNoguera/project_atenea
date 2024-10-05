import 'package:flutter/material.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/subjects/widgets/toggle_button_atom.dart';

class ToggleButtonsWidget extends StatefulWidget {
  final ValueChanged<int> onToggle;  // Callback para informar el cambio

  const ToggleButtonsWidget({required this.onToggle, Key? key}) : super(key: key);

  @override
  _ToggleButtonsWidgetState createState() => _ToggleButtonsWidgetState();
}

class _ToggleButtonsWidgetState extends State<ToggleButtonsWidget> {
  final ValueNotifier<int> activeIndex = ValueNotifier<int>(0);  // Índice del botón activo

  @override
  void dispose() {
    activeIndex.dispose();  // Dispose para limpiar el ValueNotifier
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ValueListenableBuilder<int>(
            valueListenable: activeIndex,
            builder: (context, value, child) {
              return ToggleButtonAtom(
                text: 'Temas',
                isActive: activeIndex.value == 0,
                onPressed: () {
                  activeIndex.value = 0;  // Cambia el índice activo a 0 (Temas)
                  widget.onToggle(0);  // Notifica el cambio a SubjectDetailPage
                },
              );
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ValueListenableBuilder<int>(
            valueListenable: activeIndex,
            builder: (context, value, child) {
              return ToggleButtonAtom(
                text: 'Recursos',
                isActive: activeIndex.value == 1,
                onPressed: () {
                  activeIndex.value = 1;  // Cambia el índice activo a 1 (Recursos)
                  widget.onToggle(1);  // Notifica el cambio a SubjectDetailPage
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
