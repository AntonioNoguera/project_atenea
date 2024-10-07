import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerDemo extends StatefulWidget {
  @override
  _ColorPickerDemoState createState() => _ColorPickerDemoState();
}

class _ColorPickerDemoState extends State<ColorPickerDemo> {
  Color selectedColor = Colors.blue;

  void changeColor(Color color) {
    setState(() => selectedColor = color);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Selector de Color')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Elige un color'),
                  content: SingleChildScrollView(
                    child: ColorPicker(
                      pickerColor: selectedColor,
                      onColorChanged: changeColor,
                      showLabel: true,
                      pickerAreaHeightPercent: 0.8,
                    ),
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                      child: const Text('Seleccionar'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: Text('Abrir Selector de Color'),
          style: ElevatedButton.styleFrom(
            backgroundColor: selectedColor, // Reemplaza 'primary' con 'backgroundColor'
          ),
        ),
      ),
    );
  }
}
