import 'package:flutter/material.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_scaffold.dart'; 

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});
 
  @override
  Widget build(BuildContext context) {     

    return AteneaScaffold( 
      body : Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: 50.0
          ),
        
        child: Column(
          children: [
            Text(
              'Mi Perfil',
              style: AppTextStyles.builder(
                    color: AppColors.primaryColor, 
                    size: FontSizes.h2, 
                    weight: FontWeights.semibold
                  )
            ),

            const SizedBox(height: 20.0,),

            AteneaButton(
              text : 'Editar Contenidos',
              expandedText : true,
              svgIcon: 'assets/svg/subjects.svg',
              onPressed: () {
                print("Pressed");
              }
            ),

            
            const SizedBox(height: 10.0,),

            AteneaButton(
              text : 'Editar Perfil',
              expandedText : true,
              svgIcon: 'assets/svg/account_settings.svg',
              onPressed: () {
                print("Pressed");
              }
            ),

            const SizedBox(height: 10.0,),

            AteneaButton(
              text : 'Administrar Usuarios',
              expandedText : true,
              svgIcon: 'assets/svg/user_list.svg',
              onPressed: () {
                print("Pressed");
              }
            ),
            
            const SizedBox(height: 20.0,),
            
            AteneaButton(
              text : 'Cerrar Sesión',
              backgroundColor: AppColors.ateneaRed,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const AteneaDialog(
                      title: '¿Cerrar Cuenta?',
                      content: 'Tendrás que volver a ingresar tus datos al volver, y tu contenido descargado se perderá.',
                    );
                  },
                );
              }
            ),
          ] 
          
        )
      ),
    );
  }
}