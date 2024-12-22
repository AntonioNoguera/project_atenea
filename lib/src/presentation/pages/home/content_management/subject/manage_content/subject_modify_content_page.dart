import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import 'package:proyect_atenea/src/domain/entities/file_entity.dart';
import 'package:proyect_atenea/src/domain/entities/subject_entity.dart'; 
import 'package:proyect_atenea/src/presentation/pages/home/content_management/subject/manage_content/widget/add_file_dialog.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/subject/manage_content/widget/add_theme_dialog.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/subject/manage_content/widget/delete_subject_content_dialog.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/subject/manage_content/widget/edit_theme_dialog.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/subject/manage_content/widget/theme_or_file_subject_manage_row.dart';
import 'package:proyect_atenea/src/presentation/providers/app_state_providers/active_index_notifier.dart';
import 'package:proyect_atenea/src/presentation/providers/app_state_providers/scroll_controller_notifier.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/subject_provider.dart';
import 'package:proyect_atenea/src/presentation/utils/ui_utilities.dart';
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

  List<String> halfTerm =  [];
  List<String> ordinary =  []; 
  List<FileEntity> subjectFiles = [];

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
      print('Cargando asignatura con ID: ${widget.subjectId}');
      
      final subject = await subjectProvider.getSubjectByIdUseCase(
        widget.subjectId,
      );

      if (subject != null) {
        print('Asignatura cargada correctamente: ${subject.name}');
        setState(() {
          _subject = subject;
          ordinary = UiUtilities.hashMapToOrderedList( subject.subjectPlanData?.subjectThemes.ordinary) ?? [];
          halfTerm = UiUtilities.hashMapToOrderedList( subject.subjectPlanData?.subjectThemes.halfTerm) ?? [];
          subjectFiles = UiUtilities.hashMapToOrderedList(subject.subjectPlanData?.subjectFiles) ?? [];
          _isLoading = false;
        });
      } else {
        print('No se encontró la asignatura.');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error al cargar la asignatura: $e');
      setState(() {
        _isLoading = false;
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

  void _onReorder<T>(int oldIndex, int newIndex, List<T> list) {
    setState(() {
      if (newIndex > oldIndex) newIndex -= 1;
      final item = list.removeAt(oldIndex);
      list.insert(newIndex, item);
    });

    print('Lista reordenada: $list');
  }

  void _editItem<T>(BuildContext context, int index, List<T> list) {
    if (list is List<String>) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return EditThemeDialog(
            currentText: list[index] as String,
            onSave: (newText) {
              setState(() {
                list[index] = newText as T;
              });
            },
          );
        },
      );
    } else if (list is List<FileEntity>) {
      var file = list[index] as FileEntity;

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return EditThemeDialog(
            currentText: file.name,
            onSave: (newText) {
              setState(() {
                list[index] = FileEntity(
                  id: file.id,
                  name: newText,
                  extension: file.extension,
                  size: file.size,
                  downloadUrl: file.downloadUrl,
                  subjectId: file.subjectId,
                  uploadedAt: file.uploadedAt,
                ) as T;
              });
            },
          );
        },
      );
    } else {
      print('Tipo no soportado para editar.');
    }
  }

  void deleteItem<T>(BuildContext context, int index, List<T> list) {
    if (list is List<String>) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return DeleteSubjectContentDialog(
            itemText: list[index] as String,
            onDelete: () {
              setState(() {
                list.removeAt(index);
              });
              print('Elemento eliminado: ${list}');
            },
          );
        },
      );
    } else if (list is List<FileEntity>) {
      var file = list[index] as FileEntity;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return DeleteSubjectContentDialog(
            itemText: file.name,
            onDelete: () {
              setState(() {
                list.removeAt(index);
              });
            },
          );
        },
      );
    } else {
      print('Tipo de lista no soportado para eliminar.');
    }
  }

  void _addNewTheme(String themeName, String type) {
    setState(() {
      if (type == 'Medio Curso') {
        halfTerm.add(themeName);
      } else {
        ordinary.add(themeName);
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

  void _saveSubjectChanges() async {
  if (_subject == null) return;

  final subjectProvider = Provider.of<SubjectProvider>(context, listen: false);

  _subject!.subjectPlanData?.subjectThemes.halfTerm = UiUtilities.orderedListToHashMap(halfTerm);
  _subject!.subjectPlanData?.subjectThemes.ordinary = UiUtilities.orderedListToHashMap(ordinary);
  _subject!.subjectPlanData?.subjectFiles = UiUtilities.orderedListToHashMap(subjectFiles);

  try {
    await subjectProvider.updateSubject(_subject!);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Los cambios se han guardado correctamente')),
    );
  } catch (e) {
    print('Error: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error al guardar los cambios: $e')),
    );
  }
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
                                  builder: (context) => AddFileDialog(
                                    onFileAdded: (fileEntity, fileBytes) {
                                      setState(() {
                                        subjectFiles.add(fileEntity);
                                      });
                                      print('Archivo añadido: ${fileEntity.name}');
                                      print('Bytes del archivo: ${fileBytes.length}');
                                    },
                                  ),
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
                                    _saveSubjectChanges();
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
    if (activeIndex == 0) { 
      return _renderThemes();
    } else if (activeIndex == 1) { 
      return _renderResources();
    } else {
      return const SizedBox(); 
    }
  }

  Widget _renderThemes() {
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
        if (halfTerm.isNotEmpty) ...[
          ReorderableListView(
            shrinkWrap: true,
            buildDefaultDragHandles: false,
            padding: EdgeInsets.zero,
            onReorder: (oldIndex, newIndex) =>
                _onReorder(oldIndex, newIndex, halfTerm),
            children: [
              for (int index = 0; index < halfTerm.length; index++)
                ThemeOrFileSubjectManageRow(
                  key: ValueKey(halfTerm[index]),
                  content: halfTerm[index],
                  index: index,
                  onEdit: () => _editItem(context, index, halfTerm),
                  onDelete: () => deleteItem(context, index, halfTerm),
                ),
            ],
          ),
        ] else ...[
          _renderEmptySubjectsMessage('temas de medio curso'),
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
        if (ordinary.isNotEmpty) ...[
          ReorderableListView(
            shrinkWrap: true,
            buildDefaultDragHandles: false,
            padding: EdgeInsets.zero,
            onReorder: (oldIndex, newIndex) =>
                _onReorder(oldIndex, newIndex, ordinary),
            children: [
              for (int index = 0; index < ordinary.length; index++)
                ThemeOrFileSubjectManageRow(
                  key: ValueKey(ordinary[index]),
                  content: ordinary[index],
                  index: index,
                  onEdit: () => _editItem(context, index, ordinary),
                  onDelete: () => deleteItem(context, index, ordinary),
                ),
            ],
          ),
        ] else ...[
          _renderEmptySubjectsMessage('temas ordinarios'),
        ],
      ],
    );
  }

  Widget _renderResources() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Recursos Adjuntos',
          textAlign: TextAlign.center,
          style: AppTextStyles.builder(
            color: AppColors.primaryColor,
            size: FontSizes.body1,
            weight: FontWeights.semibold,
          ),
        ),
        if (subjectFiles.isNotEmpty) ...[
          ReorderableListView(
            shrinkWrap: true,
            buildDefaultDragHandles: false,
            padding: EdgeInsets.zero,
            onReorder: (oldIndex, newIndex) =>
                _onReorder(oldIndex, newIndex, subjectFiles!),
            children: [
              for (int index = 0; index < subjectFiles.length; index++)  
                ThemeOrFileSubjectManageRow(
                  key: ValueKey(subjectFiles[index].id),
                  content: subjectFiles[index].name,
                  index: index,
                  onEdit: () => _editItem(context, index, subjectFiles!),
                  onDelete: () => deleteItem(context, index, subjectFiles!),
                ),
            ],
          ),
        ] else ...[
          _renderEmptySubjectsMessage('recursos adjuntos'),
        ],
      ],
    );
  }
}