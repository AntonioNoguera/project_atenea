import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_atenea/src/domain/entities/academy_entity.dart';
import 'package:proyect_atenea/src/domain/entities/content_entity.dart';
import 'package:proyect_atenea/src/domain/entities/department_entity.dart';
import 'package:proyect_atenea/src/domain/entities/plan_content_entity.dart';
import 'package:proyect_atenea/src/domain/entities/subject_entity.dart';
import 'package:proyect_atenea/src/domain/entities/user_entity.dart';
import 'package:proyect_atenea/src/domain/entities/shared/enum_fixed_values.dart';
import 'package:proyect_atenea/src/domain/entities/shared/permission_entity.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/academy_provider.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/department_provider.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/session_provider.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/subject_provider.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/user_provider.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sessionProvider = Provider.of<SessionProvider>(context, listen: false);
    final departmentProvider = Provider.of<DepartmentProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false); 
    final academyProvider = Provider.of<AcademyProvider>(context, listen: false); 
    final subjectProvider = Provider.of<SubjectProvider>(context, listen: false);

    // Inicializar los datos de usuario y departamento
    initializeAllData(departmentProvider, userProvider, academyProvider, subjectProvider, FirebaseFirestore.instance, );

    // Contenido de la pantalla de splashp
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

 
Future<void> initializeUserData(UserProvider userProvider) async {
  // Crear un nuevo usuario
  final newUser = UserEntity(
    userLevel: UserType.admin,
    fullName: 'John Doe',
    passwordHash: 'hashedPassword',
    createdAt: DateTime.now().toString(),
    userPermissions: PermissionEntity.defaultValues(),
  );

  // Guardar el nuevo usuario
  await userProvider.addUser(newUser);

  // Intentar login
  final loginUser = await userProvider.loginUser('John Doe', 'hashedPassword');
  if (loginUser != null) {
    print('Login exitoso para el usuario: ${loginUser.fullName}');
  } else {
    print('Credenciales incorrectas para el usuario John Doe');
  }

  // Obtener un usuario por ID
  await userProvider.getUserById(newUser.id);

  // Actualizar usuario
  final updatedUser = UserEntity(
    id: newUser.id,
    userLevel: UserType.regularUser,
    fullName: 'John Updated',
    passwordHash: 'newPasswordHash',
    createdAt: DateTime.now().toString(),
    userPermissions: PermissionEntity.defaultValues(),
  );
  await userProvider.updateUser(updatedUser);

  // Obtener todos los usuarios
  final users = await userProvider.getAllUsers();
  print('Todos los usuarios obtenidos: ${users.map((u) => u.fullName).join(', ')}');
}

Future<void> initializeAllData(
  DepartmentProvider departmentProvider,
  UserProvider userProvider,
  AcademyProvider academyProvider,
  SubjectProvider subjectProvider,
  FirebaseFirestore firestore,
) async {
  // 1. Inicializar y guardar un nuevo departamento
  final newDepartment = DepartmentEntity( 
    name: 'Department Name',
  );
  await departmentProvider.saveDepartment(newDepartment);
  print('Departamento guardado: ${newDepartment.name}');

  // Crear un DocumentReference para el departamento guardado
  final parentDepartment = firestore.collection('departments').doc(newDepartment.id);

  // Obtener el departamento para verificar
  final department = await departmentProvider.getDepartment(newDepartment.id);
  if (department != null) {
    print('Departamento obtenido: ${department.name}');
  } else {
    print('No se encontró el departamento con ID: ${newDepartment.id}');
  }

  // 2. Inicializar y guardar una nueva academia, usando el DocumentReference del departamento como parentDepartment
  final newAcademy = AcademyEntity(
    name: 'Academy Name',
    parentDepartment: parentDepartment,
    lastModificationContributor: 'admin',
    lastModificationDateTime: DateTime.now().toString(),
  );
  await academyProvider.addAcademy(newAcademy);
  print('Academia guardada: ${newAcademy.name}');

  // Crear un DocumentReference para la academia guardada
  final parentAcademy = firestore.collection('academies').doc(newAcademy.id);

  // Obtener la academia para verificar
  final academy = await academyProvider.getAcademy(newAcademy.id);
  if (academy != null) {
    print('Academia obtenida: ${academy.name}');
  } else {
    print('No se encontró la academia con ID: ${newAcademy.id}');
  }

  // 3. Inicializar y guardar una nueva materia, usando el DocumentReference de la academia como parentAcademy
  final mockContentEntity = ContentEntity(
    halfTerm: ['Tema1', 'Tema2', 'Tema3'],
    ordinary: ['Examen1', 'Examen2'],
  );

  final mockPlanContentEntity = PlanContentEntity( 
    subjectThemes: mockContentEntity,
    subjectFiles: mockContentEntity,
  );

  for (int i = 1; i <= 3; i++) {
    final newSubject = SubjectEntity(
      name: 'Subject Name $i',  // Cambiar el nombre para cada iteración
      parentAcademy: parentAcademy,
      planName: '401',
      lastModificationContributor: 'admin',
      lastModificationDateTime: DateTime.now().toString(),
      subjectPlanData: mockPlanContentEntity,
    );
    
    await subjectProvider.addSubject(newSubject);
    print('Materia guardada: ${newSubject.name}');
  }

  /*
  // Obtener la materia para verificar
  final subject = await subjectProvider.getSubject(newSubject.id);
  if (subject != null) {
    print('Materia obtenida: ${subject.name}');
  } else {
    print('No se encontró la materia con ID: ${newSubject.id}');
  }
  */

  // 4. Inicializar datos de usuario
  await initializeUserData(userProvider);

  print('Inicialización completa de todos los datos.');
}

}