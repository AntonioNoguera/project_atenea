import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_atenea/src/domain/entities/department_entity.dart';
import 'package:proyect_atenea/src/domain/entities/user_entity.dart';
import 'package:proyect_atenea/src/domain/entities/shared/enum_fixed_values.dart';
import 'package:proyect_atenea/src/domain/entities/shared/permission_entity.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/department_provider.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/session_provider.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/user_provider.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sessionProvider = Provider.of<SessionProvider>(context, listen: false);
    final departmentProvider = Provider.of<DepartmentProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    // Inicializar los datos de usuario y departamento
    _initializeData(departmentProvider, userProvider);

    // Contenido de la pantalla de splash
    final splashContent = SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: AppColors.primaryColor,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    const SizedBox(width: 20.0),
                    Image.asset(
                      'assets/images/backgrounds/uanl.png',
                      width: 150.0,
                      height: 63.3,
                      fit: BoxFit.contain,
                    ),
                    const Spacer(),
                    Image.asset(
                      'assets/images/backgrounds/fime.png',
                      width: 150.0,
                      height: 64.8,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 20.0),
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: SvgPicture.asset(
                    'assets/svg/Bearny.svg',
                    height: 200.0,
                    width: 200.0,
                    color: AppColors.ateneaWhite.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 20),
                const CircularProgressIndicator(color: AppColors.ateneaWhite),
                const Spacer(),
                Text(
                  'Versión: 24.09',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.builder(
                    color: AppColors.ateneaWhite,
                    size: FontSizes.body2,
                    weight: FontWeights.semibold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Bienvenido al Proyecto Atenea',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.builder(
                    color: AppColors.ateneaWhite,
                    size: FontSizes.body3,
                    weight: FontWeights.regular,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );

    return FutureBuilder(
      future: sessionProvider.loadSession(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return splashContent;
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            print('Session: ${sessionProvider.getSession()}');

            Future.delayed(const Duration(seconds: 3), () {
              if (sessionProvider.hasSession()) {
                Navigator.pushReplacementNamed(context, '/home');
              } else {
                Navigator.pushReplacementNamed(context, '/auth/register');
              }
            });
          });

          return splashContent;
        }
      },
    );
  }

  Future<void> _initializeData(
    DepartmentProvider departmentProvider,
    UserProvider userProvider,
  ) async {
    // Ejemplo de uso de los métodos de DepartmentProvider
    await departmentProvider.saveDepartment(
      DepartmentEntity(
        id: 'department_id',
        name: 'Department Name', 
      ),
    );

    await departmentProvider.getAllDepartments();
    await departmentProvider.getDepartment('department_id');
    await departmentProvider.deleteDepartment('department_id');

    // Ejemplo de uso de los métodos de UserProvider
    final newUser = UserEntity( 
      userLevel: UserType.admin,
      fullName: 'John Doe',
      passwordHash: 'hashedPassword',
      createdAt: DateTime.now().toString(),
      userPermissions: PermissionEntity.defaultValues(),
    );

    // Guardar nuevo usuario
    await userProvider.addUser(newUser);

    // Intentar login
    final loginUser = await userProvider.loginUser('John Doe', 'hashedPassword');
    if (loginUser != null) {
      print('Login exitoso para el usuario: ${loginUser.fullName}');
    } else {
      print('Credenciales incorrectas para el usuario John Doe');
    }

    // Obtener usuario por ID
    await userProvider.getUserById('user_id');

    // Actualizar usuario
    final updatedUser = UserEntity(
      id: 'user_id',
      userLevel: UserType.regularUser,
      fullName: 'John Updated',
      passwordHash: 'newPasswordHash',
      createdAt: DateTime.now().toString(),
      userPermissions: PermissionEntity.defaultValues(),
    );
    await userProvider.updateUser(updatedUser);

    // Eliminar usuario
    await userProvider.deleteUser('Otli3ozUX82094kC87Lv');

    // Obtener todos los usuarios
    final users = await userProvider.getAllUsers();
    print('Todos los usuarios obtenidos: ${users.map((u) => u.fullName).join(', ')}');
  }
}
