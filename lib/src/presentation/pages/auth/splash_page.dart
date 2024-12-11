import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:proyect_atenea/src/domain/entities/academy_entity.dart';
import 'package:proyect_atenea/src/domain/entities/content_entity.dart';
import 'package:proyect_atenea/src/domain/entities/department_entity.dart';
import 'package:proyect_atenea/src/domain/entities/plan_content_entity.dart';
import 'package:proyect_atenea/src/domain/entities/session_entity.dart';
import 'package:proyect_atenea/src/domain/entities/shared/atomic_permission_entity.dart';
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

    // Inicializar todos los datos
    //initializeAllData(departmentProvider, userProvider, academyProvider, subjectProvider, sessionProvider, FirebaseFirestore.instance);

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
                    size: FontSizes.body4,
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
            Future.delayed(const Duration(seconds: 3), () {
              if (sessionProvider.hasSession()) {
                Navigator.pushReplacementNamed(context, '/home');
              } else {
                Navigator.pushReplacementNamed(context, '/auth/login');
              }
            });
          });

          return splashContent;
        }
      },
    );
  }

 Future<void> initializeAllData(
  DepartmentProvider departmentProvider,
  UserProvider userProvider,
  AcademyProvider academyProvider,
  SubjectProvider subjectProvider,
  SessionProvider sessionProvider,
  FirebaseFirestore firestore,
) async {
  // 1. Crear y guardar un nuevo departamento
  final newDepartment = DepartmentEntity(name: 'Department Name');
  await departmentProvider.saveDepartment(newDepartment);
  print('Departamento guardado: ${newDepartment.name}');

  // Crear un DocumentReference para el departamento guardado
  final parentDepartment = firestore.collection('departments').doc(newDepartment.id);

  // 2. Crear y guardar una nueva academia
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

  // 3. Crear y guardar una nueva materia
  final mockContentEntity = ContentEntity(
    halfTerm: ['Tema1', 'Tema2', 'Tema3'],
    ordinary: ['Examen1', 'Examen2'],
  );

  final mockPlanContentEntity = PlanContentEntity(
    subjectThemes: mockContentEntity,
    subjectFiles: null,
  );

  List<SubjectEntity> subjects = [];
  for (int i = 1; i <= 3; i++) {
    final newSubject = SubjectEntity(
      name: 'Subject Name $i',
      parentAcademy: parentAcademy,
      planName: '401',
      lastModificationContributor: 'admin',
      lastModificationDateTime: DateTime.now().toString(),
      subjectPlanData: mockPlanContentEntity,
    );
    await subjectProvider.addSubject(newSubject);
    subjects.add(newSubject);
    print('Materia guardada: ${newSubject.name}');
  }

  // 4. Inicializar datos de usuario
  final newUser = await initializeUserData(userProvider, sessionProvider, newDepartment, newAcademy, subjects);
  
  // 5. Actualizar el último contribuidor de las entidades creadas
  final updatedDepartment = DepartmentEntity(
    id: newDepartment.id,
    name: newDepartment.name,
    lastModificationContributor: newUser.fullName,
    lastModificationDateTime: DateTime.now().toString(),
  );
  await departmentProvider.saveDepartment(updatedDepartment);
  print('Departamento actualizado con nuevo contribuidor: ${updatedDepartment.lastModificationContributor}');

  final updatedAcademy = AcademyEntity(
    id: newAcademy.id,
    name: newAcademy.name,
    parentDepartment: newAcademy.parentDepartment,
    lastModificationContributor: newUser.fullName,
    lastModificationDateTime: DateTime.now().toString(),
  );
  await academyProvider.addAcademy(updatedAcademy);
  print('Academia actualizada con nuevo contribuidor: ${updatedAcademy.lastModificationContributor}');

  for (var subject in subjects) {
    final updatedSubject = SubjectEntity(
      id: subject.id,
      name: subject.name,
      planName: subject.planName,
      parentAcademy: FirebaseFirestore.instance.doc(subject.parentAcademy),
      lastModificationContributor: newUser.fullName,
      lastModificationDateTime: DateTime.now().toString(),
      subjectPlanData: subject.subjectPlanData,
    );
    await subjectProvider.addSubject(updatedSubject);
    print('Materia actualizada con nuevo contribuidor: ${updatedSubject.lastModificationContributor}');
  }

  print('Inicialización y actualización completa de todos los datos.');
}

Future<UserEntity> initializeUserData(
  UserProvider userProvider, 
  SessionProvider sessionProvider, 
  DepartmentEntity department, 
  AcademyEntity academy, 
  List<SubjectEntity> subjects,
) async {
  // Genera permisos utilizando los IDs de las entidades creadas
  final userPermissions = PermissionEntity(
    isSuper: false,
    department: [
      AtomicPermissionEntity(
        permissionId: FirebaseFirestore.instance.doc('departments/${department.id}'),
        permissionTypes: [PermitTypes.delete, PermitTypes.edit, PermitTypes.manageContributors],
      ),
    ],
    academy: [
      AtomicPermissionEntity(
        permissionId: FirebaseFirestore.instance.doc('academies/${academy.id}'),
        permissionTypes: [PermitTypes.delete, PermitTypes.edit, PermitTypes.manageContributors],
      ),
    ],
    subject: subjects.map((subject) => AtomicPermissionEntity(
      permissionId: FirebaseFirestore.instance.doc('subjects/${subject.id}'),
      permissionTypes: [PermitTypes.delete, PermitTypes.edit, PermitTypes.manageContributors],
    )).toList(),
  );

  // Crear y guardar un usuario con permisos variados
  final newUser = UserEntity(
    userLevel: UserType.admin,
    fullName: 'John Doe',
    passwordHash: 'hashedPassword',
    createdAt: DateTime.now().toString(),
    userPermissions: userPermissions,
  );

  await userProvider.addUser(newUser);

  final loginUser = await userProvider.loginUser('John Doe', 'hashedPassword');
if (loginUser != null) {
  // Crea una entidad de sesión con los datos del usuario autenticado.
  final sessionEntity = SessionEntity(
    token: 'user_token_example', // Genera un token adecuado para la sesión
    userId: loginUser.id,
    userName: loginUser.fullName,
    userPermissions: loginUser.userPermissions,
    tokenValidUntil: DateTime.now().add(const Duration(days: 30)),
  );

  // Guarda la sesión usando SessionProvider.
  await sessionProvider.saveSession(sessionEntity);
}
  
  return newUser;
}
}