import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:proyect_atenea/src/presentation/providers/atenea_get_it_config.dart';
import 'package:proyect_atenea/src/presentation/pages/auth/login_page.dart';
import 'package:proyect_atenea/src/presentation/pages/auth/register_page.dart';
import 'package:proyect_atenea/src/presentation/pages/auth/splash_page.dart';
import 'package:proyect_atenea/src/presentation/pages/home/home_page.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/academy_provider.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/department_provider.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/file_provider.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/session_provider.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/subject_provider.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/user_provider.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/firebase_options.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';

// Handler para notificaciones en segundo plano
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Mensaje en segundo plano: ${message.notification?.title}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Inicializa la localización de fechas
  await initializeDateFormatting('es', null);

  // Configura el service locator
  await setupLocator();

  runApp(const MyApp());
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

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => GetIt.instance<SessionProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => GetIt.instance<DepartmentProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => GetIt.instance<UserProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => GetIt.instance<AcademyProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => GetIt.instance<SubjectProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => GetIt.instance<FileProvider>(),
        ),
      ],
      child: MaterialApp(
        routes: {
          '/splash': (context) => const SplashPage(),
          '/auth/login': (context) => LoginPage(),
          '/auth/register': (context) => const RegisterPage(),
          '/home': (context) => const HomePage(),
        },
        initialRoute: '/splash',
      ),
    );
  }
}