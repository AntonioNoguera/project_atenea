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
  final Function(UserEntity, AtomicPermissionEntity) onPermissionAdded;

  const AddContributorDialog({
    super.key,
    required this.entityUUID,
    required this.entityType,
    required this.onPermissionAdded,
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

      final users = await userProvider.getAllUsers();
      final currentSession = await sessionProvider.getSession();

      setState(() {
        _allUsers = users.where((user) => user.id != currentSession?.userId).toList();
        _filteredUsers = _allUsers;
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
      title: 'Añadir Contribuidor',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AteneaField(
            placeHolder: 'Buscar Nombre',
            inputNameText: 'Filtra usuarios por nombre',
            controller: _searchController,
          ),
          const SizedBox(height: 10),
          _isLoading
              ? const Center(child: AteneaCircularProgress())
              : AtenaDropDown(
                  items: _filteredUsers.map((user) => user.fullName).toList(),
                  initialValue: _selectedUser?.fullName,
                  hint: 'Selecciona un usuario',
                  onChanged: (selectedName) {
                    setState(() {
                      _selectedUser = _filteredUsers.firstWhere((user) => user.fullName == selectedName);
                    });
                  },
                ),
          const SizedBox(height: 20),
          AteneaCheckboxButton(
            checkboxText: 'Modificar Contenidos',
            initialState: canEditContent,
            onChanged: (value) {
              setState(() {
                canEditContent = value;
              });
            },
          ),
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
      buttonCallbacks: [
        AteneaButtonCallback(
          textButton: 'Cancelar',
          onPressedCallback: () => Navigator.pop(context),
        ),
        AteneaButtonCallback(
          textButton: 'Añadir',
          onPressedCallback: () {
            if (_selectedUser == null || (!canEditContent && !canAddContributors)) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Selecciona un usuario y asigna al menos un permiso.')),
              );
              return;
            }

            final newPermission = AtomicPermissionEntity(
              permissionId: FirebaseFirestore.instance.doc('/${widget.entityType.value}/${widget.entityUUID}'),
              permissionTypes: [
                if (canEditContent) PermitTypes.edit,
                if (canAddContributors) PermitTypes.manageContributors,
              ],
            );

            widget.onPermissionAdded(_selectedUser!, newPermission);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}