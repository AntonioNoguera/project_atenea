import 'package:flutter/material.dart';
import 'package:proyect_atenea/src/presentation/widgets/toggle_button_atom.dart';

class ToggleButtonsWidget extends StatefulWidget {
  final ValueChanged<int> onToggle; // Callback para informar el cambio
  final List<String> toggleOptions; // Lista de opciones para los botones

  const ToggleButtonsWidget({
    required this.onToggle,
    required this.toggleOptions,
    Key? key,
  }) : super(key: key);

  @override
  _ToggleButtonsWidgetState createState() => _ToggleButtonsWidgetState();
}

class _ToggleButtonsWidgetState extends State<ToggleButtonsWidget> {
  final ValueNotifier<int> activeIndex = ValueNotifier<int>(0); // Índice del botón activo

  @override
  void dispose() {
    activeIndex.dispose(); // Limpieza del ValueNotifier
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: widget.toggleOptions.asMap().entries.map((entry) {
        int index = entry.key;
        String option = entry.value;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0), // Espacio entre los botones
            child: ValueListenableBuilder<int>(
              valueListenable: activeIndex,
              builder: (context, value, child) {
                return ToggleButtonAtom(
                  text: option,
                  isActive: activeIndex.value == index,
                  onPressed: () {
                    activeIndex.value = index; // Cambia el índice activo
                    widget.onToggle(index); // Notifica el cambio
                  },
                );
              },
            ),
          ),
        );
      }).toList(),
    );
  }
}
