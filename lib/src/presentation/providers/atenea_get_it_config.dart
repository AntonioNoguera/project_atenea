// core/service_locator.dart
import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyect_atenea/src/data/data_sources/academy_data_source.dart';
import 'package:proyect_atenea/src/data/data_sources/deparment_data_source.dart';
import 'package:proyect_atenea/src/data/data_sources/local_session_data_source.dart';
import 'package:proyect_atenea/src/data/data_sources/user_data_source.dart';
import 'package:proyect_atenea/src/data/repositories_implementations/academy_repository_impl.dart';
import 'package:proyect_atenea/src/data/repositories_implementations/deparment_repository_impl.dart';
import 'package:proyect_atenea/src/data/repositories_implementations/session_repository_impl.dart';
import 'package:proyect_atenea/src/data/repositories_implementations/user_repository_impl.dart';
import 'package:proyect_atenea/src/domain/repositories/academy_repository.dart';
import 'package:proyect_atenea/src/domain/repositories/department_repository.dart';
import 'package:proyect_atenea/src/domain/repositories/session_repository.dart';
import 'package:proyect_atenea/src/domain/use_cases/academy_use_case.dart';
import 'package:proyect_atenea/src/domain/use_cases/department_use_case.dart';
import 'package:proyect_atenea/src/domain/use_cases/session_use_cases.dart';
import 'package:proyect_atenea/src/domain/use_cases/user_use_case.dart';
import 'package:proyect_atenea/src/presentation/providers/department_provider.dart';
import 'package:proyect_atenea/src/presentation/providers/session_provider.dart';
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


    // [ ACADEMY ]
  locator.registerFactory<AcademyDataSource>( () => AcademyDataSource(locator<FirebaseFirestore>()) );  //DataSource
  locator.registerFactory<AcademyRepository>( () => AcademyRepositoryImpl(locator<AcademyDataSource>()) ); //Repositorio

    // [ DEPARTMENT ] 
  locator.registerFactory<DepartmentDataSource>( () => DepartmentDataSource(locator<FirebaseFirestore>()) );  //DataSource
  locator.registerFactory<DepartmentRepository>( () => DepartmentRepositoryImpl(locator<DepartmentDataSource>()) ); //Repositorio

    // Registro del DataSource Locales 

    // [ Session ]
  locator.registerFactory<LocalSessionDataSource>( () => LocalSessionDataSource(locator<SharedPreferences>())); //DataSource
  locator.registerFactory<SessionRepository>( () => SessionRepositoryImpl(locator<LocalSessionDataSource>())); // Repo
 
  // Registro de los Casos de Uso agrupados

    // [USER]
  locator.registerFactory(() => GetUser(locator<UserRepository>()));
  locator.registerFactory(() => AddUser(locator<UserRepository>()));
  locator.registerFactory(() => UpdateUser(locator<UserRepository>()));
  locator.registerFactory(() => DeleteUser(locator<UserRepository>()));

    // [ACADEMY]
  locator.registerFactory(() => GetAcademies(locator<AcademyRepository>()));
  locator.registerFactory(() => AddAcademy(locator<AcademyRepository>()));
  locator.registerFactory(() => UpdateAcademy(locator<AcademyRepository>()));
  locator.registerFactory(() => DeleteAcademy(locator<AcademyRepository>()));

    // [SESSION]
  locator.registerFactory(() => GetSessionUseCase(locator<SessionRepository>()));
  locator.registerFactory(() => SaveSessionUseCase(locator<SessionRepository>()));
  locator.registerFactory(() => ClearSessionUseCase(locator<SessionRepository>()));

    // [DEPARTMENT]
  locator.registerFactory(() => GetDepartmentUseCase( locator<DepartmentRepository>()));
  locator.registerFactory(() => SaveDepartmentUseCase( locator<DepartmentRepository>()));
  locator.registerFactory(() => DeleteDepartmentUseCase( locator<DepartmentRepository>()));
  locator.registerFactory(() => GetAllDepartmentsUseCase( locator<DepartmentRepository>()));

  // Registro del SessionProvider
  locator.registerFactory(() => SessionProvider(
    getSessionUseCase: locator<GetSessionUseCase>(),
    saveSessionUseCase: locator<SaveSessionUseCase>(),
    clearSessionUseCase: locator<ClearSessionUseCase>(),
  ));

  locator.registerFactory(() => DepartmentProvider(
    getDepartmentUseCase: locator<GetDepartmentUseCase>(),
    saveDepartmentUseCase : locator<SaveDepartmentUseCase>(),
    deleteDepartmentUseCase : locator<DeleteDepartmentUseCase>(),
    getAllDepartmentsUseCase : locator<GetAllDepartmentsUseCase>(),
  ));
}