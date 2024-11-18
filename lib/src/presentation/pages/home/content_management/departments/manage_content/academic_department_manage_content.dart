import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_atenea/src/domain/entities/department_entity.dart';
import 'package:proyect_atenea/src/domain/entities/shared/enum_fixed_values.dart';
import 'package:proyect_atenea/src/domain/entities/user_entity.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/academies/create/widget/academy_contributor_row.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/academies/create/widget/add_contributor_dialog.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/session_provider.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/user_provider.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_scaffold.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_field.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button_v2.dart';

class AcademicDepartmentManageContent extends StatefulWidget {
  final DepartmentEntity department;

  const AcademicDepartmentManageContent({super.key, required this.department});

  @override
  _AcademicDepartmentManageContentState createState() =>
      _AcademicDepartmentManageContentState();
}

class _AcademicDepartmentManageContentState
    extends State<AcademicDepartmentManageContent> {
  late TextEditingController _departmentInputController;
  late List<UserEntity> _contributors;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _departmentInputController =
        TextEditingController(text: widget.department.name);
    _fetchContributors();
  }

  @override
  void dispose() {
    _departmentInputController.dispose();
    super.dispose();
  }

  /// Llama al provider para obtener usuarios con permisos en este departamento
  Future<void> _fetchContributors() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final sessionProvider = Provider.of<SessionProvider>(context, listen: false);

      // Obtener la sesión actual
      final currentSession = await sessionProvider.getSession();

      // Obtener usuarios con permisos
      final users = await userProvider.getUsersByPermission(
        SystemEntitiesTypes.department, // Tipo de entidad
        widget.department.id, // ID del departamento
      );

      setState(() {
        _contributors = users.map((user) {
          if (user.id == currentSession?.userId) {
            // Modificar el nombre si coincide con el usuario actual
            return user.copyWith(fullName: 'TU');
          }
          return user;
        }).toList();
        _isLoading = false;
      });
    } catch (error) {
      print('Error fetching contributors: $error');
      setState(() {
        _contributors = [];
        _isLoading = false;
      });
    }
  }

  void _addContributor(UserEntity contributor) {
    setState(() {
      _contributors.add(contributor);
    });
  }

  void _removeContributor(int index) {
    setState(() {
      _contributors.removeAt(index);
    });
  }

  void _saveChanges() {
    print('Guardando cambios: ${_departmentInputController.text}');
    print('Contribuidores: ${_contributors.map((c) => c.fullName).toList()}');
  }

  @override
  Widget build(BuildContext context) {
    return AteneaScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05),
              child: Column(
                children: [
                  Text(
                    'Modificando Departamento',
                    style: AppTextStyles.builder(
                        size: FontSizes.h3, weight: FontWeights.semibold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20.0),
                  AteneaField(
                    placeHolder: 'Ingresa el nombre del departamento',
                    inputNameText: 'Nombre del Departamento',
                    controller: _departmentInputController,
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'Contribuidores con Permisos',
                    style: AppTextStyles.builder(
                      size: FontSizes.h5,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: List.generate(_contributors.length,
                                  (index) {
                                final user = _contributors[index];
 

                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                  child: AcademyContributorRow(
                                    index: index,
                                    contributorName: user.fullName,
                                    permissionEntity: user.userPermissions.department.first,
                                    showDetail: () => _removeContributor(index),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                  AteneaButtonV2(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AddContributorDialog(
                            entityType: SystemEntitiesTypes.department,
                            entityUUID:  widget.department.id
                          );
                        },
                      );
                    },
                    btnStyles: const AteneaButtonStyles(
                      backgroundColor: AppColors.ateneaWhite,
                      textColor: AppColors.primaryColor,
                      hasBorder: true,
                    ),
                    textStyle: AppTextStyles.builder(
                      color: AppColors.primaryColor,
                      size: FontSizes.h5,
                      weight: FontWeights.light,
                    ),
                    text: 'Añadir Contribuidor',
                    svgIcon: SvgButtonStyle(
                      svgPath: 'assets/svg/add_user.svg',
                      svgDimentions: 25,
                    ),
                  ),
                  const SizedBox(height: 60.0),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05),
                child: Row(
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
                        text: 'Guardar',
                        btnStyles: const AteneaButtonStyles(
                          backgroundColor: AppColors.primaryColor,
                          textColor: AppColors.ateneaWhite,
                        ),
                        onPressed: () => _showSaveDialog(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSaveDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AteneaDialog(
          title: 'Modificando Departamento',
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '¿Deseas guardar los cambios en el departamento "${_departmentInputController.text}"?',
                style: AppTextStyles.builder(color: AppColors.textColor),
              ),
              const SizedBox(height: 15.0),
              Text(
                'Contribuidores: ${_contributors.map((c) => c.fullName).join(", ")}',
                style: AppTextStyles.builder(
                  color: AppColors.primaryColor,
                  size: FontSizes.body2,
                ),
              ),
            ],
          ),
          buttonCallbacks: [
            AteneaButtonCallback(
              textButton: 'Cancelar',
              onPressedCallback: () {
                Navigator.of(context).pop();
              },
              buttonStyles: const AteneaButtonStyles(
                backgroundColor: AppColors.secondaryColor,
                textColor: AppColors.ateneaWhite,
              ),
            ),
            AteneaButtonCallback(
              textButton: 'Aceptar',
              onPressedCallback: () {
                _saveChanges();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}