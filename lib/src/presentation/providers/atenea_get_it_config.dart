// core/service_locator.dart

import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyect_atenea/src/data/data_sources/academy_data_source.dart';
import 'package:proyect_atenea/src/data/data_sources/deparment_data_source.dart';
import 'package:proyect_atenea/src/data/data_sources/session_local_data_source.dart';
import 'package:proyect_atenea/src/data/data_sources/subject_data_source.dart';
import 'package:proyect_atenea/src/data/data_sources/user_data_source.dart';
import 'package:proyect_atenea/src/data/repositories_implementations/academy_repository_impl.dart';
import 'package:proyect_atenea/src/data/repositories_implementations/deparment_repository_impl.dart';
import 'package:proyect_atenea/src/data/repositories_implementations/session_repository_impl.dart';
import 'package:proyect_atenea/src/data/repositories_implementations/subject_repository_impl.dart';
import 'package:proyect_atenea/src/data/repositories_implementations/user_repository_impl.dart';
import 'package:proyect_atenea/src/domain/repositories/academy_repository.dart';
import 'package:proyect_atenea/src/domain/repositories/department_repository.dart';
import 'package:proyect_atenea/src/domain/repositories/session_repository.dart';
import 'package:proyect_atenea/src/domain/repositories/subject_repository.dart';
import 'package:proyect_atenea/src/domain/use_cases/academy_use_case.dart';
import 'package:proyect_atenea/src/domain/use_cases/department_use_case.dart';
import 'package:proyect_atenea/src/domain/use_cases/session_use_cases.dart'; 
import 'package:proyect_atenea/src/domain/use_cases/subject_use_case.dart';
import 'package:proyect_atenea/src/domain/use_cases/user_use_case.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/academy_provider.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/department_provider.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/session_provider.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/subject_provider.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/repositories/user_repository.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  
  //SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerFactory(() => sharedPreferences);
  
  //Firestore
  locator.registerFactory(() => FirebaseFirestore.instance);

  // Registro del DataSource de RED
    // [ USER ]
  locator.registerFactory<UserDataSource>( () => UserDataSource(locator<FirebaseFirestore>()) );  //DataSource
  locator.registerFactory<UserRepository>( () => UserRepositoryImpl(locator<UserDataSource>()) ); //Repositorio

    // [ SUBJECT ]
  locator.registerFactory<SubjectDataSource>( () => SubjectDataSource(locator<FirebaseFirestore>()) );  //DataSource
  locator.registerFactory<SubjectRepository>( () => SubjectRepositoryImpl(locator<SubjectDataSource>()) ); //Repositorio

    // [ ACADEMY ]
  locator.registerFactory<AcademyDataSource>( () => AcademyDataSource(locator<FirebaseFirestore>()) );  //DataSource
  locator.registerFactory<AcademyRepository>( () => AcademyRepositoryImpl(locator<AcademyDataSource>()) ); //Repositorio

    // [ DEPARTMENT ] 
  locator.registerFactory<DepartmentDataSource>( () => DepartmentDataSource(locator<FirebaseFirestore>()) );  //DataSource
  locator.registerFactory<DepartmentRepository>( () => DepartmentRepositoryImpl(locator<DepartmentDataSource>()) ); //Repositorio

    // Registro del DataSource Locales 
 

// Registro de SessionLocalDataSource y SessionRepository
locator.registerFactory<SessionLocalDataSource>(() => SessionLocalDataSource(locator<SharedPreferences>()),); // DataSource
locator.registerFactory<SessionRepository>(() => SessionRepositoryImpl(locator<SessionLocalDataSource>()),); // Repository
  // Registro de los Casos de Uso agrupados

    // [USER]
  locator.registerFactory(() => LoginUserUseCase(locator<UserRepository>()));
  locator.registerFactory(() => GetUserByIdUseCase(locator<UserRepository>()));
  locator.registerFactory(() => AddUserUseCase(locator<UserRepository>()));
  locator.registerFactory(() => UpdateUserUseCase(locator<UserRepository>()));
  locator.registerFactory(() => DeleteUserUseCase(locator<UserRepository>()));
  locator.registerFactory(() => GetAllUsersUseCase(locator<UserRepository>())); 
  locator.registerFactory(() => GetUserPermissionsUseCase(locator<UserRepository>())); 

    // [ACADEMY]
    
  locator.registerFactory(() => GetAcademyById(locator<AcademyRepository>()));
  locator.registerFactory(() => GetAllAcademies(locator<AcademyRepository>()));
  locator.registerFactory(() => AddAcademy(locator<AcademyRepository>()));
  locator.registerFactory(() => GetAcademiesByDepartment(locator<AcademyRepository>()));
  locator.registerFactory(() => UpdateAcademy(locator<AcademyRepository>()));
  locator.registerFactory(() => DeleteAcademy(locator<AcademyRepository>()));

    // SESSION 
locator.registerFactory(() => LoadSessionUseCase(locator<SessionRepository>()));
locator.registerFactory(() => SaveSessionUseCase(locator<SessionRepository>()));
locator.registerFactory(() => ClearSessionUseCase(locator<SessionRepository>()));
locator.registerFactory(() => HasSessionUseCase(locator<LoadSessionUseCase>()));
locator.registerFactory(() => UpdateSessionTokenUseCase(locator<SaveSessionUseCase>(), locator<LoadSessionUseCase>())); 


    // [DEPARTMENT]
  locator.registerFactory(() => GetDepartmentUseCase( locator<DepartmentRepository>()));
  locator.registerFactory(() => SaveDepartmentUseCase( locator<DepartmentRepository>()));
  locator.registerFactory(() => UpdateDepartmentUseCase( locator<DepartmentRepository>())); 
  locator.registerFactory(() => DeleteDepartmentUseCase( locator<DepartmentRepository>()));
  locator.registerFactory(() => GetAllDepartmentsUseCase( locator<DepartmentRepository>()));

    // [SUBJECT]
  locator.registerFactory(() => GetSubjectById( locator<SubjectRepository>() ));
  locator.registerFactory(() => AddSubject( locator<SubjectRepository>() ));
  locator.registerFactory(() => UpdateSubject( locator<SubjectRepository>() ));
  locator.registerFactory(() => DeleteSubject( locator<SubjectRepository>() ));
  locator.registerFactory(() => GetAllSubjects( locator<SubjectRepository>() ));
  locator.registerFactory(() => GetSubjectsByAcademyID( locator<SubjectRepository>() ));

  

  locator.registerFactory(() => DepartmentProvider(
    getDepartmentUseCase: locator<GetDepartmentUseCase>(),
    saveDepartmentUseCase : locator<SaveDepartmentUseCase>(),
    updateDepartmentUseCase: locator<UpdateDepartmentUseCase>(),
    deleteDepartmentUseCase : locator<DeleteDepartmentUseCase>(),
    getAllDepartmentsUseCase : locator<GetAllDepartmentsUseCase>(),
  ));

  locator.registerFactory(() => AcademyProvider(
    getAcademyByIdUseCase : locator<GetAcademyById>(),
    addAcademyUseCase : locator<AddAcademy>(),
    updateAcademyUseCase : locator<UpdateAcademy>(),
    deleteAcademyUseCase : locator<DeleteAcademy>(),
    getAllAcademiesUseCase : locator<GetAllAcademies>(),
    getAcademiesByDepartmentIdUseCase : locator<GetAcademiesByDepartment>(),
  ));

  locator.registerFactory(() => SubjectProvider(
    getSubjectByIdUseCase : locator<GetSubjectById>(),
    addSubjectUseCase : locator<AddSubject>(),
    updateSubjectUseCase : locator<UpdateSubject>(),
    deleteSubjectUseCase : locator<DeleteSubject>(),
    getAllSubjectsUseCase : locator<GetAllSubjects>(),
    getSubjectsByAcademyIdUseCase : locator<GetSubjectsByAcademyID>(),
  ));

  locator.registerFactory(() => UserProvider(
    loginUserUseCase : locator<LoginUserUseCase>(),
    getUserByIdUseCase : locator<GetUserByIdUseCase>(),
    addUserUseCase : locator<AddUserUseCase>(),
    updateUserUseCase : locator<UpdateUserUseCase>(),
    deleteUserUseCase : locator<DeleteUserUseCase>(),
    getAllUsersUseCase : locator<GetAllUsersUseCase>(),
    getUserPermissionsUseCase: locator<GetUserPermissionsUseCase>(),
  ));

  locator.registerFactory(() => SessionProvider(
  loadSessionUseCase: locator<LoadSessionUseCase>(),
  saveSessionUseCase: locator<SaveSessionUseCase>(),
  clearSessionUseCase: locator<ClearSessionUseCase>(),
  hasSessionUseCase: locator<HasSessionUseCase>(),
  updateSessionTokenUseCase: locator<UpdateSessionTokenUseCase>(),
));

}