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
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: toggleOptions.asMap().entries.map((entry) {
        int index = entry.key;
        String option = entry.value;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0), // Espacio entre los botones
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