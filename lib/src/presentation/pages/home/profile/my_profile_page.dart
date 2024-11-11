import 'package:flutter/material.dart';
import 'package:proyect_atenea/src/domain/entities/shared/enum_fixed_values.dart';
import 'package:proyect_atenea/src/domain/entities/session_entity.dart';
import 'package:proyect_atenea/src/presentation/pages/demos/color_picker_demo.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/manage_content_page.dart'; 
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_bottom_dialog.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button_v2.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_field.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_page_animator.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_scaffold.dart';

class MyProfilePage extends StatelessWidget {
  final SessionEntity userSession;
   

  MyProfilePage(this.userSession, {super.key});

  final TextEditingController _matriculaController = TextEditingController(text: '2077402');
  final TextEditingController _nombreController = TextEditingController(text: 'Michael Antonio');
  final TextEditingController _apellidoController = TextEditingController(text: 'Noguera Guzmán');
  final TextEditingController _emailController = TextEditingController(text: 'michael.noguera@uanl.edu.mx');

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _verifyPasswordController = TextEditingController();

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
                weight: FontWeights.semibold,
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
            AteneaButtonV2 (
              text: 'Editar Perfil',
              xpndText: true,
              svgIcon: SvgButtonStyle(svgPath: 'assets/svg/account_settings.svg'),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return Wrap(
                      children: [
                        AteneaBottomDialog(
                          parentContext: context,
                          childContent: Column(
                            children: [
                              Text('Editar Perfil', style: AppTextStyles.builder(size: FontSizes.h3, weight : FontWeights.semibold, ),   textAlign: TextAlign.center,),
                              const SizedBox(height: 10.0),
                              AteneaField( 
                                inputNameText: 'Matrícula', 
                                controller: _matriculaController,
                                enabled: false,
                              ),
                              
                              const SizedBox(height: 15.0),

                              Row(
                                children: [
                                  Expanded(
                                    child: AteneaField( 
                                      inputNameText: 'Nombre', 
                                      controller: _nombreController,
                                      enabled: false,
                                    ),
                                  ),

                                  const SizedBox(width: 10.0),
                                  
                                  Expanded(
                                    child: AteneaField( 
                                      inputNameText: 'Apellido', 
                                      controller: _apellidoController,
                                      enabled: false,
                                    ),
                                  ),
                                ],
                              ), 
 
 
                              const SizedBox(height: 15.0),

                              AteneaField( 
                                inputNameText: 'Correo de Contacto', 
                                controller: _emailController
                              ),
                               

                              const SizedBox(height: 15.0),


                              AteneaField( 
                                inputNameText: 'Cambiar Contraseña', 
                                controller: _passwordController,
                                enabled: true,
                                isPasswordField: true,
                              ),

                              const SizedBox(height: 15.0),

                              AteneaField( 
                                inputNameText: 'Repetir Contraseña', 
                                controller: _verifyPasswordController,
                                enabled: true,
                                isPasswordField: true,
                              ),
                              
                              //Para mandar el boton hasta el fondo
                              const Spacer(),

                              AteneaButtonV2(
                                text: 'Guardar Cambios',
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AteneaDialog(
                                        title: 'Cambios Guardados',
                                        content: Text('Tus cambios han sido guardados exitosamente.'),
                                        buttonCallbacks: [
                                          AteneaButtonCallback(
                                            textButton:'Aceptar',
                                            onPressedCallback: () {  
                                              Navigator.of(context).pop();
                                            },
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
                      ],
                    );
                  },
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
