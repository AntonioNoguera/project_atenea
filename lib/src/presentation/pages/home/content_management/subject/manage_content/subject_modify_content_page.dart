import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/subject/create/subject_create_new_page.dart';
import 'package:proyect_atenea/src/presentation/providers/app_state_providers/active_index_notifier.dart';
import 'package:proyect_atenea/src/presentation/providers/app_state_providers/scroll_controller_notifier.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_page_animator.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_scaffold.dart';
import 'package:proyect_atenea/src/presentation/widgets/toggle_buttons_widget%20.dart';

class SubjectModifyContentPage extends StatefulWidget {
  const SubjectModifyContentPage({super.key});

  @override
  _SubjectModifyContentPageState createState() => _SubjectModifyContentPageState();
}

class _SubjectModifyContentPageState extends State<SubjectModifyContentPage> {
  List<String> topics = ['Tema 1', 'Tema 2', 'Tema 3'];
  List<String> resources = [
    'Recurso 1',
    'Recurso 2',
    'Recurso 3',
    'Recurso 4',
    'Recurso 5',
    'Recurso 6',
    'Recurso 7',
    'Recurso 8',
    'Recurso 9',
    'Recurso 10',
    'Recurso 11',
  ];

  void _handleToggle(BuildContext context, int index) {
    Provider.of<ActiveIndexNotifier>(context, listen: false).setActiveIndex(index);
  }

  void _onReorder(int oldIndex, int newIndex, List<String> list) {
    setState(() {
      if (newIndex > oldIndex) newIndex -= 1;
      final item = list.removeAt(oldIndex);
      list.insert(newIndex, item);
    });
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

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ActiveIndexNotifier()),
        ChangeNotifierProvider(create: (context) => ScrollControllerNotifier()),
      ],
      child: Consumer2<ActiveIndexNotifier, ScrollControllerNotifier>(
        builder: (context, activeIndexNotifier, scrollNotifier, child) {
          return AteneaScaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 30.0,
              ),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            Text(
                              'Temas Selectos de Ingeniería de Software',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.builder(
                                color: AppColors.primaryColor,
                                size: FontSizes.h3,
                                weight: FontWeights.semibold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Planes de estudio',
                              style: AppTextStyles.builder(
                                size: FontSizes.body2,
                                weight: FontWeights.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            ToggleButtonsWidget(
                              onToggle: (index) => _handleToggle(context, index),
                              toggleOptions: const ['Temas', 'Recursos'],
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          controller: scrollNotifier.scrollController,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: MediaQuery.of(context).size.width * 0.05,
                            ),
                            child: Column(
                              children: [
                                const SizedBox(height: 10.0),
                                _renderedContent(activeIndexNotifier.activeIndex),
                                const SizedBox(height: 60.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05,),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              AnimatedContainer(
                                curve: Curves.decelerate,
                                duration: const Duration(milliseconds: 230),
                                width: scrollNotifier.isButtonCollapsed ? 60.0 : 200.0,
                                child: AteneaButton(
                                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 0),
                                  text: scrollNotifier.isButtonCollapsed ? null : 'Añadir Tema',
                                  iconSize: 30.0,
                                  svgIcon: 'assets/svg/add.svg',
                                  svgTint: AppColors.primaryColor,
                                  enabledBorder: true,
                                  backgroundColor: AppColors.ateneaWhite,
                                  textStyle: AppTextStyles.builder(
                                    color: AppColors.primaryColor,
                                    size: FontSizes.body1,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      AteneaPageAnimator(page: SubjectCreateNewPage()),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: AteneaButton(
                                  text: 'Guardar Cambios',
                                  backgroundColor: AppColors.secondaryColor,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _renderedContent(int activeIndex) {
  final List<String> currentList = activeIndex == 0 ? topics : resources;

  return ReorderableListView(
    shrinkWrap: true,
    buildDefaultDragHandles: false,
    padding: EdgeInsets.zero, // Elimina el padding del ListView
    onReorder: (oldIndex, newIndex) => _onReorder(oldIndex, newIndex, currentList),
    children: [
      for (int index = 0; index < currentList.length; index++)
        Container(
          key: ValueKey(currentList[index]),
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
                    currentList[index],
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
        ),
    ],
  );
}

}
