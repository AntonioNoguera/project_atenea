import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'package:provider/provider.dart';

import 'app/values/app_theme.dart';

//Provider Immports
import 'app/providers/session_provider.dart';
import 'domain/usecases/session_use_cases.dart';

//Page
import 'app/pages/auth/splash_page.dart';
import 'app/pages/home/home_page.dart';
import 'app/pages/auth/login_page.dart';
import 'app/pages/auth/register_page.dart';

import 'package:proyect_atenea/data/datasources/session_manager_data_source.dart';
import 'package:proyect_atenea/data/repositories/session_repository_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Fire Store Initialization
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Asegúrate de usar las opciones correctas
  );

  // Inicialización de dependencias
  final sharedPreferences = await SharedPreferences.getInstance();
  final sessionLocalDataSource = SessionLocalDataSource(sharedPreferences);
  final sessionRepository = SessionRepositoryImpl(sessionLocalDataSource);

  // Casos de uso
  final getSessionUseCase = GetSessionUseCase(sessionRepository);
  final saveSessionUseCase = SaveSessionUseCase(sessionRepository);
  final clearSessionUseCase = ClearSessionUseCase(sessionRepository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SessionProvider(
            getSessionUseCase: getSessionUseCase,
            saveSessionUseCase: saveSessionUseCase,
            clearSessionUseCase: clearSessionUseCase,
          ),
        ),
        // Otros Providers globales aquí
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Aplicar estilo de la barra de estado globalmente
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.primaryColor.withOpacity(0.65), // Color de la barra de estado
        statusBarIconBrightness: Brightness.dark, // Brillo de los íconos
      ),
    );

    return MaterialApp(
      routes: {
        '/splash': (context) => const SplashPage(),
        '/auth': (context) => const LoginPage(),
        '/auth/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
      },
      initialRoute: '/splash',
    );
  }
}
