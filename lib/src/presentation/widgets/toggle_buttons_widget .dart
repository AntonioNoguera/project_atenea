import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_atenea/src/presentation/providers/app_state_providers/active_index_notifier.dart';
import 'toggle_button_atom.dart';

class ToggleButtonsWidget extends StatelessWidget {
  final ValueChanged<int> onToggle; // Callback para informar el cambio
  final List<String> toggleOptions; // Lista de opciones para los botones

  const ToggleButtonsWidget({
    required this.onToggle,
    required this.toggleOptions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Espacio entre los botones
      children: toggleOptions.asMap().entries.map((entry) {
        int index = entry.key;
        String option = entry.value;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 0 : 2.0, // Espacio a la izquierda de todos menos el primero
              right: index == toggleOptions.length - 1 ? 0 : 2.0, // Espacio a la derecha de todos menos el último
            ),
            child: Consumer<ActiveIndexNotifier>(
              builder: (context, activeIndexNotifier, child) {
                return ToggleButtonAtom(
                  text: option,
                  isActive: activeIndexNotifier.activeIndex == index,
                  onPressed: () {
                    activeIndexNotifier.setActiveIndex(index); // Cambia el índice activo
                    onToggle(index); // Notifica el cambio
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