import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/academies/create/widget/add_contributor_dialog.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/subject/create/subject_create_new_page.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/subject/manage_content/widget/add_file_dialog.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/subject/manage_content/widget/add_theme_dialog.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/subject/manage_content/widget/theme_or_file_subject_manage_row.dart';
import 'package:proyect_atenea/src/presentation/providers/app_state_providers/active_index_notifier.dart';
import 'package:proyect_atenea/src/presentation/providers/app_state_providers/scroll_controller_notifier.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_folding_button.dart';
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ScrollControllerNotifier>(context, listen: false).setButtonCollapsed();
    });

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
                              'Estas editando los contenidos de:',
                              style: AppTextStyles.builder(
                                color: AppColors.primaryColor,
                                size: FontSizes.body2,
                                weight: FontWeights.regular,
                              ),
                            ),

                            //const SizedBox(height: 10.0,),

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

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Plan de estudio:',
                                  style: AppTextStyles.builder(
                                    size: FontSizes.body2,
                                    weight: FontWeights.bold,
                                  ),
                                ),
                                
                                const SizedBox(width: 5,),

                                Text(
                                  '401',
                                  style: AppTextStyles.builder(
                                    size: FontSizes.body2,
                                    weight: FontWeights.regular,
                                  ),
                                ),

                                const SizedBox(width: 10.0,),

                                Text(
                                  'Folio:',
                                  style: AppTextStyles.builder(
                                    size: FontSizes.body2,
                                    weight: FontWeights.bold,
                                  ),
                                ),
                                const SizedBox(width: 5,),
                                Text(
                                  '6641168477',
                                  style: AppTextStyles.builder(
                                    size: FontSizes.body2,
                                    weight: FontWeights.regular,
                                  ),
                                ),
                              ],
                            ),

                           
                            const SizedBox(height: 15),
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
                          if (activeIndexNotifier.activeIndex == 0)
                            AteneaFoldingButton(
                              data: 'Añadir Tema',
                              svgIcon: 'assets/svg/add.svg',
                              onPressedCallback: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const AddThemeDialog();
                                  },
                                );
                              },
                            ),
                          if (activeIndexNotifier.activeIndex == 1)
                            AteneaFoldingButton(
                              data: 'Añadir Recurso',
                              svgIcon: 'assets/svg/add.svg',
                              onPressedCallback: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const AddFileDialog();
                                  },
                                );
                              },
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
      padding: EdgeInsets.zero,
      onReorder: (oldIndex, newIndex) => _onReorder(oldIndex, newIndex, currentList),
      proxyDecorator: (Widget child, int index, Animation<double> animation) {
        return Material(
          elevation: 6.0,
          color: Colors.transparent,
          shadowColor: Colors.black.withOpacity(0.3),
          child: child,
        );
      },
      children: [
        for (int index = 0; index < currentList.length; index++)
          ThemeOrFileSubjectManageRow(
            key: ValueKey(currentList[index]),
            content: currentList[index],
            index: index,
            onEdit: () => _editItem(context, index, currentList),
            onDelete: () {
              setState(() {
                currentList.removeAt(index);
              });
            },
          ),
      ],
    );
  }
}