import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_atenea/src/domain/entities/content_entity.dart';
import 'package:proyect_atenea/src/domain/entities/subject_entity.dart';
import 'package:proyect_atenea/src/domain/use_cases/subject_use_case.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/subject/manage_content/widget/add_file_dialog.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/subject/manage_content/widget/add_theme_dialog.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/subject/manage_content/widget/delete_subject_content_dialog.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/subject/manage_content/widget/edit_theme_dialog.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/subject/manage_content/widget/theme_or_file_subject_manage_row.dart';
import 'package:proyect_atenea/src/presentation/providers/app_state_providers/active_index_notifier.dart';
import 'package:proyect_atenea/src/presentation/providers/app_state_providers/scroll_controller_notifier.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/subject_provider.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button_v2.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_folding_button.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_scaffold.dart';
import 'package:proyect_atenea/src/presentation/widgets/toggle_buttons_widget%20.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_circular_progress.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_card.dart';

class SubjectModifyContentPage extends StatefulWidget {
  final String subjectId;

  const SubjectModifyContentPage({super.key, required this.subjectId});

  @override
  _SubjectModifyContentPageState createState() => _SubjectModifyContentPageState();
}

class _SubjectModifyContentPageState extends State<SubjectModifyContentPage> {
  ContentEntity topics = ContentEntity(halfTerm: [], ordinary: []);
  ContentEntity resources = ContentEntity(halfTerm: [], ordinary: []);

  String _lastSemesterStageSelected = '';

  SubjectEntity? _subject;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSubjectData();
  }

  Future<void> _loadSubjectData() async {
    try {
      final subjectProvider =
          Provider.of<SubjectProvider>(context, listen: false);
      final subject = await subjectProvider.getSubjectByIdUseCase(
        widget.subjectId,
      );

      if (subject != null) {
        setState(() {
          _subject = subject;
          topics = subject.subjectPlanData?.subjectThemes ??
              ContentEntity(halfTerm: [], ordinary: []);
          resources = subject.subjectPlanData?.subjectFiles ??
              ContentEntity(halfTerm: [], ordinary: []);
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = true;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar la asignatura: $e')),
      );
    }
  }

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
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return EditThemeDialog(
        currentText: list[index],
        onSave: (newText) {
          setState(() {
            list[index] = newText;
          });
        },
      );
    },
  );
}

void deleteItem(BuildContext context, int index, List<String> list) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return DeleteSubjectContentDialog(
        itemText: list[index],
        onDelete: () {
          setState(() {
            list.removeAt(index);
          });
        },
      );
    },
  );
}

  void _addNewTheme(String themeName, String type) {
    setState(() {
      if (type == 'Medio Curso') {
        topics.halfTerm.add(themeName);
      } else {
        topics.ordinary.add(themeName);
      }

      _lastSemesterStageSelected = type;
    });
  }

  
  Widget _renderEmptySubjectsMessage( String type ) {
    return Center(
      child: AteneaCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'No hay $type dados de alta, prueba añadir alguno.',
              textAlign: TextAlign.center,
              style: AppTextStyles.builder(
                color: AppColors.textColor,
                size: FontSizes.body2,
                weight: FontWeights.regular,
              ),
            ),
          ],
        ),
      ),
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
                  _isLoading || _subject == null
                      ? const Center(child: AteneaCircularProgress())
                      : Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
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
                                  Text(
                                    _subject!.name,
                                    textAlign: TextAlign.center,
                                    style: AppTextStyles.builder(
                                      color: AppColors.primaryColor,
                                      size: FontSizes.h3,
                                      weight: FontWeights.semibold,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  ToggleButtonsWidget(
                                    onToggle: (index) =>
                                        _handleToggle(context, index),
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
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.05,
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 10.0),
                                      _renderedContent(
                                          activeIndexNotifier.activeIndex),
                                      const SizedBox(height: 60.0),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.05,
                      ),
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
                                    return AddThemeDialog(
                                      onAddTheme: _addNewTheme,
                                      previousSemesterStage: _lastSemesterStageSelected,
                                    );
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
                              AteneaButtonV2(
                                text: 'Cancelar',
                                btnStyles: const AteneaButtonStyles(
                                  backgroundColor: AppColors.secondaryColor,
                                  textColor: AppColors.ateneaWhite,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              const SizedBox(width: 10.0),
                              Expanded(
                                child: AteneaButtonV2(
                                  text: 'Guardar Cambios',
                                  btnStyles: const AteneaButtonStyles(
                                    backgroundColor: AppColors.primaryColor,
                                    textColor: AppColors.ateneaWhite,
                                  ),
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
  final currentList = activeIndex == 0 ? topics : resources;
  final currentListString = activeIndex == 0 ? 'temas' : 'recursos';

  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        textAlign: TextAlign.center,
        'Contenido de Medio Curso',
        style: AppTextStyles.builder(
          color: AppColors.primaryColor,
          size: FontSizes.body1,
          weight: FontWeights.semibold,
        ),
      ),
      if (currentList.halfTerm.isNotEmpty) ...[
        ReorderableListView(
          shrinkWrap: true,
          buildDefaultDragHandles: false,
          padding: EdgeInsets.zero,
          onReorder: (oldIndex, newIndex) =>
              _onReorder(oldIndex, newIndex, currentList.halfTerm),
          children: [
            for (int index = 0; index < currentList.halfTerm.length; index++)
              ThemeOrFileSubjectManageRow(
                key: ValueKey(currentList.halfTerm[index]),
                content: currentList.halfTerm[index],
                index: index,
                onEdit: () => _editItem(context, index, currentList.halfTerm),
                onDelete: () =>
                    deleteItem(context, index, currentList.halfTerm),
              ),
          ],
        ),
      ] else ...[
        _renderEmptySubjectsMessage('$currentListString de medio curso'),
      ],

      const SizedBox(height: 30),

      Text(
        textAlign: TextAlign.center,
        'Contenido Ordinario',
        style: AppTextStyles.builder(
          color: AppColors.primaryColor,
          size: FontSizes.body1,
          weight: FontWeights.semibold,
        ),
      ),
      if (currentList.ordinary.isNotEmpty) ...[
        ReorderableListView(
          shrinkWrap: true,
          buildDefaultDragHandles: false,
          padding: EdgeInsets.zero,
          onReorder: (oldIndex, newIndex) =>
              _onReorder(oldIndex, newIndex, currentList.ordinary),
          children: [
            for (int index = 0; index < currentList.ordinary.length; index++)
              ThemeOrFileSubjectManageRow(
                key: ValueKey(currentList.ordinary[index]),
                content: currentList.ordinary[index],
                index: index,
                onEdit: () => _editItem(context, index, currentList.ordinary),
                onDelete: () =>
                    deleteItem(context, index, currentList.ordinary),
              ),
          ],
        ),
      ] else ...[
        _renderEmptySubjectsMessage('$currentListString de ordinario'),
      ],
    ],
  );
}



}

