import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeOrFileSubjectRow extends StatelessWidget {
  final String keyValue;
  final int index;
  final List<String> currentList;

   void _onReorder(int oldIndex, int newIndex, List<String> list) {
    /*
    setState(() {
      if (newIndex > oldIndex) newIndex -= 1;
      final item = list.removeAt(oldIndex);
      list.insert(newIndex, item);
    });
    */
  }

  void _editItem(BuildContext context, int index, List<String> list) {
    TextEditingController controller = TextEditingController(text: list[index]);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar elemento'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Nuevo nombre'),
          ),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Guardar'),
              onPressed: () {
                setState(() {
                  list[index] = controller.text;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  const ThemeOrFileSubjectRow(
    {
      super.key, 
      required this.keyValue,
      required this.index,
      required this.currentList,

    }
  );

  @override
  Widget build(BuildContext context) {
    return Container(
          key: ValueKey(keyValue),
          margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),
          decoration: BoxDecoration(
            color: Colors.blueAccent, // Cambia el color de fondo aquí
            borderRadius: BorderRadius.circular(12.0), // Bordes redondeados
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.only(left: 10.0, right: 10.0),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    keyValue,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white, // Cambia el color del texto aquí si lo necesitas
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.white),
                  onPressed: () {
                    _editItem(context, index, currentList);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      currentList.removeAt(index);
                    });
                  },
                ),
                ReorderableDragStartListener(
                  index: index,
                  child: Icon(Icons.drag_handle, color: Colors.white),
                ),
              ],
            ),
          ),
        );
  }
}