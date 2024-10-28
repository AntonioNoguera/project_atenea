//Name still on thought
import 'package:flutter/material.dart';

class AteneaOptionSelector extends StatelessWidget {
  final ValueChanged<List<int>> onP; // Callback para informar el cambio
  final List<String> selectorOptions; // Lista de opciones para los botones

  const AteneaOptionSelector({
    super.key, 
    required this.onP, 
    required this.selectorOptions
  });

  @override
  Widget build(BuildContext context) {
    return Row();
  }
}