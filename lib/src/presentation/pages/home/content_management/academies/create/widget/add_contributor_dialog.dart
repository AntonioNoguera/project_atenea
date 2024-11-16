import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_atenea/src/domain/entities/user_entity.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/user_provider.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_checkbox_button.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_field.dart';

class AddContributorDialog extends StatefulWidget {
  const AddContributorDialog({super.key});

  @override
  _AddContributorDialogState createState() => _AddContributorDialogState();
}

class _AddContributorDialogState extends State<AddContributorDialog> {
  final TextEditingController _searchController = TextEditingController();
  List<UserEntity> _filteredUsers = [];
  List<UserEntity> _allUsers = [];
  UserEntity? _selectedUser;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUsers();
    _searchController.addListener(_filterUsers);
  }

  Future<void> _loadUsers() async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final users = await userProvider.getAllUsers();
      setState(() {
        _allUsers = users;
        _filteredUsers = users;
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
              'Busca contribuidores',
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
                    height: 50,
                    child: Center(child: CircularProgressIndicator()),
                  )
                : DropdownButton<UserEntity>(
                    isExpanded: true,
                    value: _filteredUsers.contains(_selectedUser)
                        ? _selectedUser
                        : null,
                    hint: const Text("Selecciona un usuario"),
                    items: _filteredUsers.map((user) {
                      return DropdownMenuItem<UserEntity>(
                        value: user,
                        child: Text(
                          user.fullName,
                          style: AppTextStyles.builder(
                            size: FontSizes.body2,
                            color: AppColors.textColor,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (UserEntity? newUser) {
                      setState(() {
                        _selectedUser = newUser;
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
            AteneaCheckboxButton(
              checkboxText: 'Modificar Contenidos',
              initialState: true,
              onChanged: (value) {
                print('Esta seleccionado: $value');
              },
            ),
            const SizedBox(height: 5),
            AteneaCheckboxButton(
              checkboxText: 'Añadir nuevos contribuidores',
              initialState: true,
              onChanged: (value) {
                print('Esta seleccionado: $value');
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
          onPressedCallback: () {
            print('Usuario seleccionado: ${_selectedUser?.fullName}');
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}