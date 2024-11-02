import 'package:flutter/material.dart';
import 'package:proyect_atenea/src/domain/entities/enum_fixed_values.dart';
import 'package:proyect_atenea/src/domain/entities/session_entity.dart';
import 'package:proyect_atenea/src/presentation/pages/demos/color_picker_demo.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/manage_content_page.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button_v2.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_page_animator.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_scaffold.dart';

class MyProfilePage extends StatelessWidget {
  final SessionEntity userSession;

  const MyProfilePage(this.userSession, {super.key});

  @override
  Widget build(BuildContext context) {
    return AteneaScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: 50.0,
        ),
        child: Column(
          children: [
            Text(
              'Mi Perfil',
              style: AppTextStyles.builder(
                color: AppColors.primaryColor,
                size: FontSizes.h2,
                weight: FontWeights.regular,
              ),
            ),

            const SizedBox(height: 20.0),
 
            if (userSession.userPermissions.academy.isNotEmpty || userSession.userPermissions.subject.isNotEmpty )  ...[
              AteneaButtonV2(
                text: 'Editar Contenidos',
                xpndText: true,
                svgIcon : SvgButtonStyle( svgPath: 'assets/svg/subjects.svg', ),
                onPressed: () {
                  Navigator.push(
                    context,
                    AteneaPageAnimator(page: ManageContentPage())
                  ); 
                },
              ),
              const SizedBox(height: 10.0),
            ],

            // Mostrar 'Editar Perfil' para todos los tipos de usuarios
            AteneaButtonV2(
              text: 'Editar Perfil',
              xpndText: true,
              svgIcon: SvgButtonStyle( svgPath: 'assets/svg/account_settings.svg', ),
              onPressed: () {
                Navigator.push(
                    context,
                    AteneaPageAnimator(page: ColorPickerDemo())
                  ); 
              },
            ),
            const SizedBox(height: 10.0),

            // Mostrar 'Administrar Usuarios' solo si el usuario es super admin 
            if (userSession.userPermissions.academy.isNotEmpty || userSession.userPermissions.subject.isNotEmpty )  ...[
              AteneaButtonV2(
                text: 'Administrar Usuarios',
                xpndText: true,
                svgIcon : SvgButtonStyle( svgPath: 'assets/svg/user_list.svg',  ),  
                onPressed: () {
                  print('Administrar Usuarios Pressed');
                },
              ),
              const SizedBox(height: 10.0),
            ],

            const SizedBox(height: 20.0),

            // Botón de Cerrar Sesión (disponible para todos los tipos de usuarios)
            AteneaButtonV2(
              text: 'Cerrar Sesión',

              btnStyles: const AteneaButtonStyles(
                backgroundColor: AppColors.ateneaRed,
                textColor: AppColors.ateneaWhite,
              ), 
              
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AteneaDialog(
                      title: '¿Cerrar Cuenta?',
                      content: Text('Tendrás que volver a ingresar tus datos al volver, y tu contenido descargado se perderá.'),
                      buttonCallbacks: [
                        AteneaButtonCallback(
                          textButton:'Cancelar',
                          onPressedCallback: () {  
                            Navigator.of(context).pop();
                          },
                          buttonStyles: AteneaButtonStyles(backgroundColor: AppColors.secondaryColor, textColor: AppColors.ateneaWhite)
                        ),
                        AteneaButtonCallback(
                          textButton:'Aceptar',
                          onPressedCallback: () {  
                            Navigator.pushNamedAndRemoveUntil(context, '/splash', (route) => false);
                          }
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
