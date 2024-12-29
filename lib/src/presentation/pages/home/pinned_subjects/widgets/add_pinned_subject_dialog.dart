import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:proyect_atenea/src/domain/entities/subject_entity.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/subject/subject_item_row.dart';
import 'package:proyect_atenea/src/presentation/pages/home/pinned_subjects/widgets/pin_subect_item_row.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/subject_provider.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button_v2.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_card.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_circular_progress.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_field.dart';

class AddPinnedSubjectDialog extends StatelessWidget {
  const AddPinnedSubjectDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AteneaButtonV2(
      text: 'Añadir Nueva Materia',
      xpndText: true,
      svgIcon: SvgButtonStyle(
        svgPath: 'assets/svg/add.svg',
      ),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          ),
          builder: (BuildContext context) {
            return const _AddPinnedSubjectDialogContent();
          },
        );
      },
    );
  }
}

class _AddPinnedSubjectDialogContent extends StatefulWidget {
  const _AddPinnedSubjectDialogContent({
    Key? key,
  }) : super(key: key);

  @override
  State<_AddPinnedSubjectDialogContent> createState() =>
      _AddPinnedSubjectDialogContentState();
}

class _AddPinnedSubjectDialogContentState
    extends State<_AddPinnedSubjectDialogContent> {
  final TextEditingController _searchController = TextEditingController();
  List<SubjectEntity> _filteredSubjects = [];
  List<SubjectEntity> _allSubjects = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchSubjects();
    _searchController.addListener(_filterSubjects);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchSubjects() async {
    try {
      final subjects = await Provider.of<SubjectProvider>(context, listen: false).getAllSubjects();
      setState(() {
        _allSubjects = subjects;
        _filteredSubjects = subjects;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _filterSubjects() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredSubjects = _allSubjects.where((subject) {
        return subject.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double modalHeight = MediaQuery.of(context).size.height * 0.95;

    if (_isLoading) {
      return SizedBox(
        height: modalHeight,
        child: const AteneaCircularProgress(),
      );
    }

    if (_allSubjects.isEmpty) {
      return SizedBox(
        height: modalHeight,
        child: AteneaCard (
          margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05, 
          ),
          child: Column (
            children: [
              Text(
                '¡Atención!',
                textAlign: TextAlign.center,
                style: AppTextStyles.builder(
                  color: AppColors.ateneaBlack,
                  size: FontSizes.body1,
                  weight: FontWeights.semibold,
                ),
              ),
              Text(
                'Posees un super usuario, te permitirá editar tanto academias, como departamentos académicos, prueba entrando a un departamento académico.',
                textAlign: TextAlign.center,
                style: AppTextStyles.builder(
                  color: AppColors.ateneaBlack,
                  size: FontSizes.body2,
                  weight: FontWeights.regular,
                ),
              ),

            ],
          ) 
        ), 
      );
    }

    return SizedBox(
      height: modalHeight,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Anclar Nueva Materia',
                style: AppTextStyles.builder(
                  size: FontSizes.h3,
                  weight: FontWeights.semibold,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
              ),
              child: AteneaField(
                placeHolder: 'Buscar materia',
                controller: _searchController,
                inputNameText: 'Búsqueda',
                suffixIcon: SvgPicture.asset( 
                    'assets/svg/search.svg',
                    height: 20,
                    width: 20,
                    color: AppColors.primaryColor,
                  ),
              ),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: _filteredSubjects.isEmpty
                  ? Center(
                      child: Text(
                        'No hay resultados para la búsqueda',
                        style: AppTextStyles.builder(
                          size: FontSizes.body1,
                          color: AppColors.grayColor,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _filteredSubjects.length,
                      itemBuilder: (context, index) {
                        final subject = _filteredSubjects[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * 0.05,
                          ),
                          child: PinSubjectItemRow(subject: subject),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}