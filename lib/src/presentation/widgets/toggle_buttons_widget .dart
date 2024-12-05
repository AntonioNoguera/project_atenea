import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_atenea/src/presentation/providers/app_state_providers/active_index_notifier.dart';
import 'toggle_button_atom.dart';

class ToggleButtonsWidget extends StatefulWidget {
  final List<String> toggleOptions;
  final String previousOptionSelected;
  final Function(int) onToggle;

  ToggleButtonsWidget({
    required this.toggleOptions,
    this.previousOptionSelected = '',
    required this.onToggle,
  });

  @override
  _ToggleButtonsWidgetState createState() => _ToggleButtonsWidgetState();
}

class _ToggleButtonsWidgetState extends State<ToggleButtonsWidget> {
  @override
  void initState() {
    super.initState();
    if (widget.previousOptionSelected.isNotEmpty) {
      Future.microtask(() {
        int index = widget.toggleOptions.indexOf(widget.previousOptionSelected);
        Provider.of<ActiveIndexNotifier>(context, listen: false).setActiveIndex(index);
        widget.onToggle(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: widget.toggleOptions.asMap().entries.map((entry) {
        int index = entry.key;
        String option = entry.value;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 0 : 2.0,
              right: index == widget.toggleOptions.length - 1 ? 0 : 2.0,
            ),
            child: Consumer<ActiveIndexNotifier>(
              builder: (context, activeIndexNotifier, child) {
                return ToggleButtonAtom(
                  text: option,
                  isActive: activeIndexNotifier.activeIndex == index,
                  onPressed: () {
                    activeIndexNotifier.setActiveIndex(index); // Cambia el índice activo
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