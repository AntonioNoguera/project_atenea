import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_atenea/src/domain/entities/shared/atomic_permission_entity.dart';
import 'package:proyect_atenea/src/domain/entities/shared/enum_fixed_values.dart';
import 'package:proyect_atenea/src/domain/entities/user_entity.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/session_provider.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/user_provider.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atena_drop_down.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_checkbox_button.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_circular_progress.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_field.dart';

class AddContributorDialog extends StatefulWidget {
  final String entityUUID;
  final SystemEntitiesTypes entityType;

  const AddContributorDialog({
    super.key,
    required this.entityUUID,
    required this.entityType,
  });

  @override
  _AddContributorDialogState createState() => _AddContributorDialogState();
}

class _AddContributorDialogState extends State<AddContributorDialog> {
  final TextEditingController _searchController = TextEditingController();
  List<UserEntity> _filteredUsers = [];
  List<UserEntity> _allUsers = [];
  UserEntity? _selectedUser;
  bool _isLoading = true;

  // Permisos seleccionados
  bool canEditContent = true;
  bool canAddContributors = true;

  @override
  void initState() {
    super.initState();
    _loadUsers();
    _searchController.addListener(_filterUsers);
  }

  Future<void> _loadUsers() async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final sessionProvider = Provider.of<SessionProvider>(context, listen: false);

      // Obtener la lista de todos los usuarios
      final users = await userProvider.getAllUsers();

      // Eliminar al usuario de la sesión actual de la lista
      final currentSession = await sessionProvider.getSession();
      final filteredUsers = users.where((user) => user.id != currentSession?.userId).toList();

      setState(() {
        _allUsers = filteredUsers;
        _filteredUsers = filteredUsers;
        _isLoading = false;
      });
    } catch (e) {
      print('Error al cargar usuarios: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _filterUsers() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredUsers = _allUsers.where((user) {
        return user.fullName.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AteneaDialog(
      title: 'Añade Contribuidor',
      content: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Busca contribuidores:',
              style: AppTextStyles.builder(
                color: AppColors.secondaryColor,
                size: FontSizes.body1,
              ),
            ),
            const SizedBox(height: 10),
            AteneaField(
              placeHolder: 'Buscar Nombre',
              inputNameText: 'Nombre',
              controller: _searchController,
            ),
            const SizedBox(height: 10),
            Text(
              _isLoading
                  ? 'Cargando usuarios...'
                  : _filteredUsers.isEmpty
                      ? 'No se encontraron resultados.'
                      : 'Resultados: ${_filteredUsers.length} usuarios',
              style: AppTextStyles.builder(
                color: AppColors.grayColor,
                size: FontSizes.body2,
              ),
            ),
            const SizedBox(height: 10),
            _isLoading
                ? const SizedBox(
                    height: 75,
                    child: Center(child: AteneaCircularProgress()),
                  )
                : AtenaDropDown(
                    items: _filteredUsers.map((user) => user.fullName).toList(),
                    initialValue: _selectedUser?.fullName,
                    hint: 'Selecciona un usuario',
                    onChanged: (selectedName) {
                      setState(() {
                        _selectedUser = _filteredUsers.firstWhere(
                          (user) => user.fullName == selectedName,
                        );
                      });
                    },
                  ),
            const SizedBox(height: 10),
            Text(
              _selectedUser != null
                  ? 'Seleccionado: ${_selectedUser?.fullName}'
                  : 'No se ha seleccionado ningún usuario.',
              style: AppTextStyles.builder(
                color: _selectedUser != null
                    ? AppColors.primaryColor
                    : AppColors.grayColor,
                size: FontSizes.body2,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Permisos Otorgados:',
              style: AppTextStyles.builder(
                color: AppColors.secondaryColor,
                size: FontSizes.body1,
              ),
            ),
            const SizedBox(height: 10),
            AteneaCheckboxButton(
              checkboxText: 'Modificar Contenidos',
              initialState: canEditContent,
              onChanged: (value) {
                setState(() {
                  canEditContent = value;
                });
              },
            ),
            const SizedBox(height: 5),
            AteneaCheckboxButton(
              checkboxText: 'Añadir nuevos contribuidores',
              initialState: canAddContributors,
              onChanged: (value) {
                setState(() {
                  canAddContributors = value;
                });
              },
            ),
          ],
        ),
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
          onPressedCallback: () async {
            if (_selectedUser == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Por favor, selecciona un usuario.')),
              );
              return;
            }

            if (!canEditContent && !canAddContributors) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Debes otorgar al menos un permiso.')),
              );
              return;
            }

            try {
              final userProvider = Provider.of<UserProvider>(context, listen: false);

              // Crear la entidad de permiso
              final newPermission = AtomicPermissionEntity(
                permissionId: FirebaseFirestore.instance.doc('/${widget.entityType.value}/${widget.entityUUID}'),
                permissionTypes: [
                  if (canEditContent) PermitTypes.edit,
                  if (canAddContributors) PermitTypes.manageContributors,
                ],
              );

              // Actualizar el usuario
              await userProvider.addPermissionToUser(
                userId: _selectedUser!.id,
                type: widget.entityType,
                newPermission: newPermission,
              );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Permisos actualizados para ${_selectedUser!.fullName}.')),
              );

              Navigator.of(context).pop();
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error al actualizar permisos: $e')),
              );
            }
          },
        ),
      ],
    );
  }
}
