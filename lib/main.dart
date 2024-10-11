import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:proyect_atenea/src/domain/atenea_service_locator.dart';
import 'package:proyect_atenea/src/presentation/pages/auth/login_page.dart';
import 'package:proyect_atenea/src/presentation/pages/auth/register_page.dart';
import 'package:proyect_atenea/src/presentation/pages/auth/splash_page.dart';
import 'package:proyect_atenea/src/presentation/pages/home/home_page.dart';
import 'package:proyect_atenea/src/presentation/providers/session_provider.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/data/data_sources/local_session_data_source.dart';
import 'package:proyect_atenea/src/data/repositories_implementations/session_repository_impl.dart';
import 'package:proyect_atenea/src/domain/use_cases/session_use_cases.dart';
import 'package:proyect_atenea/src/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Configura el service locator para registrar todas las dependencias
  setupLocator();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => locator<SessionProvider>(), // Utiliza get_it para el SessionProvider
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
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.primaryColor.withOpacity(0.65),
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return MaterialApp(
      routes: {
        '/splash': (context) => const SplashPage(),
        '/auth/login': (context) => const LoginPage(),
        '/auth/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
      },
      initialRoute: '/splash',
    );
  }
}