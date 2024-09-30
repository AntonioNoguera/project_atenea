import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:proyect_atenea/app/providers/SessionProvider.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:proyect_atenea/app/values/AppTheme.dart'; 

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Accede al SessionProvider para verificar si hay sesión
    final sessionProvider = Provider.of<SessionProvider>(context, listen: false);

    // Usa un FutureBuilder para redirigir al usuario después de verificar la sesión
    return FutureBuilder(
      future: sessionProvider.loadSession(), // Cargar la sesión desde el Provider
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Mientras se carga la sesión, muestra una pantalla de carga (Splash)
          return Scaffold(
            body: Center(  // Centrar todo el contenido del cuerpo
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,  // Centrar verticalmente
                crossAxisAlignment: CrossAxisAlignment.center,  // Centrar horizontalmente
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: SvgPicture.asset(
                      'assets/svg/Bearny.svg',
                      height: 300.0,
                      width: 300.0,
                    ),
                  ),
                  const SizedBox(height: 20),  // Añade espacio entre la imagen y el indicador
                  const CircularProgressIndicator(),
                ],
              ),
            ),
          );
        } else { 
          // Si hay sesión, redirigir a la pantalla principal
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Future.delayed(const Duration(milliseconds: 5000), () {
              if (sessionProvider.session != null) {
                Navigator.pushReplacementNamed( context, '/home' );
              } else {
                Navigator.pushReplacementNamed( context, '/auth/register' );
              }    
            });
          });
          
          // Muestra una pantalla  
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  
                  const Spacer(),

                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: SvgPicture.asset(
                      'assets/svg/Bearny.svg',
                      height: 250.0,
                      width: 250.0,
                    ),
                  ),
                  const SizedBox(height: 20), 
                  const CircularProgressIndicator(color:AppColors.primaryColor),
                  const Spacer(),
                  Text(
                    "Versión: 24.09", 
                    textAlign: TextAlign.center, 
                    style: AppTextStyles.builder(
                      color: AppColors.primaryColor, 
                      size: FontSizes.body1, 
                      weight: FontWeights.semibold
                    )
                  ),
                  const SizedBox(height: 20,)
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

