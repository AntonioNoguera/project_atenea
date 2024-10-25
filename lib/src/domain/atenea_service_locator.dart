// core/service_locator.dart
import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyect_atenea/src/data/data_sources/academy_data_source.dart';
import 'package:proyect_atenea/src/data/data_sources/local_session_data_source.dart';
import 'package:proyect_atenea/src/data/data_sources/user_data_source.dart';
import 'package:proyect_atenea/src/data/repositories_implementations/academy_repository_impl.dart';
import 'package:proyect_atenea/src/data/repositories_implementations/session_repository_impl.dart';
import 'package:proyect_atenea/src/data/repositories_implementations/user_repository_impl.dart';
import 'package:proyect_atenea/src/domain/repositories/academy_repository.dart';
import 'package:proyect_atenea/src/domain/repositories/session_repository.dart';
import 'package:proyect_atenea/src/domain/use_cases/academy_use_case.dart';
import 'package:proyect_atenea/src/domain/use_cases/session_use_cases.dart';
import 'package:proyect_atenea/src/domain/use_cases/user_use_case.dart';
import 'package:proyect_atenea/src/presentation/providers/session_provider.dart';
import 'package:shared_preferences/shared_preferences.dart'; 
import '../domain/repositories/user_repository.dart'; 

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  
  //SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => sharedPreferences);
  
  //Firestore
  locator.registerLazySingleton(() => FirebaseFirestore.instance);

  // Registro del DataSource de RED
    // [ USER ]
  locator.registerLazySingleton<UserDataSource>( () => UserDataSource(locator<FirebaseFirestore>()) );  //DataSource
  locator.registerLazySingleton<UserRepository>( () => UserRepositoryImpl(locator<UserDataSource>()) ); //Repositorio


    // [ ACADEMY ]
  locator.registerLazySingleton<AcademyDataSource>( () => AcademyDataSource(locator<FirebaseFirestore>()) );  //DataSource
  locator.registerLazySingleton<AcademyRepository>( () => AcademyRepositoryImpl(locator<AcademyDataSource>()) ); //Repositorio

    // Registro del DataSource Locales 

    // [ Session ]
  locator.registerLazySingleton<LocalSessionDataSource>( () => LocalSessionDataSource(locator<SharedPreferences>())); //DataSource
  locator.registerLazySingleton<SessionRepository>( () => SessionRepositoryImpl(locator<LocalSessionDataSource>())); // Repo
 
  // Registro de los Casos de Uso agrupados
    // [USER]
  locator.registerLazySingleton(() => GetUser(locator<UserRepository>()));
  locator.registerLazySingleton(() => AddUser(locator<UserRepository>()));
  locator.registerLazySingleton(() => UpdateUser(locator<UserRepository>()));
  locator.registerLazySingleton(() => DeleteUser(locator<UserRepository>()));

    // [ACADEMY]
  locator.registerLazySingleton(() => GetAcademies(locator<AcademyRepository>()));
  locator.registerLazySingleton(() => AddAcademy(locator<AcademyRepository>()));
  locator.registerLazySingleton(() => UpdateAcademy(locator<AcademyRepository>()));
  locator.registerLazySingleton(() => DeleteAcademy(locator<AcademyRepository>()));

    // [SESSION]
  locator.registerLazySingleton(() => GetSessionUseCase(locator<SessionRepository>()));
  locator.registerLazySingleton(() => SaveSessionUseCase(locator<SessionRepository>()));
  locator.registerLazySingleton(() => ClearSessionUseCase(locator<SessionRepository>()));

// Registro del SessionProvider
  locator.registerFactory(() => SessionProvider(
    getSessionUseCase: locator<GetSessionUseCase>(),
    saveSessionUseCase: locator<SaveSessionUseCase>(),
    clearSessionUseCase: locator<ClearSessionUseCase>(),
  ));

}