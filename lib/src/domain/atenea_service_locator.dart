// core/service_locator.dart
import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyect_atenea/src/data/data_sources/user_data_source.dart';
import 'package:proyect_atenea/src/data/repositories/user_repository_impl.dart';
import 'package:proyect_atenea/src/domain/use_cases/user_use_case.dart'; 
import '../domain/repositories/user_repository.dart'; 

final GetIt locator = GetIt.instance;

void setupLocator() {
  
  locator.registerLazySingleton(() => FirebaseFirestore.instance);

  // Registro del DataSource
  locator.registerLazySingleton<UserDataSource>(
      () => UserDataSource(locator<FirebaseFirestore>()));

  // Registro del Repositorio, que depende del DataSource
  locator.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(locator<UserDataSource>()));

  // Registro de los Casos de Uso agrupados
  locator.registerLazySingleton(() => GetUser(locator<UserRepository>()));
  locator.registerLazySingleton(() => AddUser(locator<UserRepository>()));
  locator.registerLazySingleton(() => UpdateUser(locator<UserRepository>()));
  locator.registerLazySingleton(() => DeleteUser(locator<UserRepository>()));
}
