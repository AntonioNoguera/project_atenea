import 'package:flutter/material.dart'; 
import 'package:provider/provider.dart';
import 'package:proyect_atenea/src/domain/entities/session_entity.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/manage_content_page.dart';
import 'package:proyect_atenea/src/presentation/pages/home/profile/edit_profile_bottom_dialog.dart'; 
import 'package:proyect_atenea/src/presentation/providers/remote_providers/session_provider.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart'; 
import 'package:proyect_atenea/src/presentation/widgets/atenea_button_v2.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart'; 
import 'package:proyect_atenea/src/presentation/widgets/atenea_page_animator.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_scaffold.dart';

class MyProfilePage extends StatelessWidget {
  final SessionEntity userSession;

  MyProfilePage(this.userSession, {super.key});

  final TextEditingController _matriculaController = TextEditingController(text: '2077402');
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController(text: 'michael.noguera@uanl.edu.mx');
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _verifyPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final sessionProvider = Provider.of<SessionProvider>(context, listen: false);

    // Inicializamos los controladores con los datos actuales de la sesión
    _nombreController.text = userSession.userName.split(' ').first;
    _apellidoController.text = userSession.userName.split(' ').last;

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
            if ( true ) ...[
              AteneaButtonV2(
                text: 'Editar Contenidos',
                xpndText: true,
                svgIcon: SvgButtonStyle(svgPath: 'assets/svg/subjects.svg'),
                onPressed: () {
                  Navigator.push(
                    context,
                    AteneaPageAnimator(page: const ManageContentPage()),
                  );
                },
              ),
              const SizedBox(height: 10.0),
            ],
            
            EditProfileModal(
              userSession: userSession,
              onSave: (updatedSession) async {
                await sessionProvider.saveSession(updatedSession);
              },
            ),
                        
            const SizedBox(height: 10.0),
            //Todo : Search 4 a Better way to handle this
            if (true ) ...[
              AteneaButtonV2(
                text: 'Administrar Usuarios',
                xpndText: true,
                svgIcon: SvgButtonStyle(svgPath: 'assets/svg/user_list.svg'),
                onPressed: () {
                  print('Administrar Usuarios Pressed');
                },
              ),
              const SizedBox(height: 10.0),
            ],
            const SizedBox(height: 20.0),
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
                      content: Text(
                        'Tendrás que volver a ingresar tus datos al volver, y tu contenido descargado se perderá.',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.builder(
                          size: FontSizes.body2,
                          weight: FontWeights.regular,
                          color: AppColors.textColor,
                        ),
                      ),
                      buttonCallbacks: [
                        AteneaButtonCallback(
                          textButton: 'Cancelar',
                          onPressedCallback: () {
                            Navigator.of(context).pop();
                          },
                          buttonStyles: const AteneaButtonStyles(
                            backgroundColor: AppColors.secondaryColor,
                            textColor: AppColors.ateneaWhite,
                          ),
                        ),
                        AteneaButtonCallback(
                          textButton: 'Aceptar',
                          onPressedCallback: () async {
                            await sessionProvider.clearSession();
                            Navigator.pushNamedAndRemoveUntil(context, '/splash', (route) => false);
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
    );
  }
}
