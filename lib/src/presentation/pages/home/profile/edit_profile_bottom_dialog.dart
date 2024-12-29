import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proyect_atenea/src/domain/entities/session_entity.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button_v2.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_field.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_password_field.dart'; 

class EditProfileModal extends StatelessWidget {
  final SessionEntity userSession;
  final Future<void> Function(SessionEntity updatedSession) onSave;

  const EditProfileModal({
    Key? key,
    required this.userSession,
    required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AteneaButtonV2(
      text: 'Editar Perfil',
      xpndText: true,
      svgIcon: SvgButtonStyle(svgPath: 'assets/svg/account_settings.svg'),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          ),
          builder: (BuildContext context) {
            return _EditProfileDialogContent(
              userSession: userSession,
              onSave: onSave,
            );
          },
        );
      },
    );
  }
}

class _EditProfileDialogContent extends StatefulWidget {
  final SessionEntity userSession;
  final Future<void> Function(SessionEntity updatedSession) onSave;

  const _EditProfileDialogContent({
    Key? key,
    required this.userSession,
    required this.onSave,
  }) : super(key: key);

  @override
  State<_EditProfileDialogContent> createState() =>
      _EditProfileDialogContentState();
}

class _EditProfileDialogContentState extends State<_EditProfileDialogContent> {
  late final TextEditingController _matriculaController;
  late final TextEditingController _nombreController;
  late final TextEditingController _apellidoController;
  late final TextEditingController _emailController;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _verifyPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _matriculaController = TextEditingController(text: widget.userSession.userId);
    _nombreController = TextEditingController(
      text: widget.userSession.userName.split(' ').first,
    );
    _apellidoController = TextEditingController(
      text: widget.userSession.userName.split(' ').last,
    );
    _emailController = TextEditingController(
      text: widget.userSession.userPermissions.toString(),
    );
  }

  @override
  void dispose() {
    _matriculaController.dispose();
    _nombreController.dispose();
    _apellidoController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _verifyPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double modalHeight = MediaQuery.of(context).size.height * 0.9;

    return SizedBox(
      height: modalHeight,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Editar Perfil',
                style: AppTextStyles.builder(
                  size: FontSizes.h3,
                  weight: FontWeights.semibold,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
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
                    enabled: true,
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: AteneaField(
                    inputNameText: 'Apellido',
                    controller: _apellidoController,
                    enabled: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15.0),
            AteneaField(
              inputNameText: 'Correo de Contacto',
              controller: _emailController,
              enabled: true,
            ),
            const SizedBox(height: 15.0), 
            AteneaPasswordField(
              inputNameText: 'Cambiar Contraseña',
              controller: _passwordController,
            ),
            const SizedBox(height: 15.0),
            AteneaPasswordField(
              inputNameText: 'Repetir Contraseña',
              controller: _verifyPasswordController, 
            ),
            const Spacer(),
            Center(
              child: AteneaButtonV2(
                text: 'Guardar Cambios',
                onPressed: () async {
                  if (_passwordController.text != _verifyPasswordController.text) {
                    Fluttertoast.showToast(
                      msg: 'Las contraseñas no coinciden',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: AppColors.grayColor,
                      textColor: AppColors.ateneaWhite,
                      fontSize: 16.0,
                    );
                    return;
                  }

                  final updatedSession = SessionEntity(
                    token: widget.userSession.token,
                    userId: widget.userSession.userId,
                    userName:
                        '${_nombreController.text} ${_apellidoController.text}',
                    userPermissions: widget.userSession.userPermissions,
                    tokenValidUntil: widget.userSession.tokenValidUntil,
                    pinnedSubjects: widget.userSession.pinnedSubjects,
                  );

                  await widget.onSave(updatedSession);

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AteneaDialog(
                        title: 'Cambios Guardados',
                        content: const Text(
                            'Tus cambios han sido guardados exitosamente.'),
                        buttonCallbacks: [
                          AteneaButtonCallback(
                            textButton: 'Aceptar',
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
            ),
          ],
        ),
      ),
    );
  }
}
