import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:proyect_atenea/src/domain/entities/session_entity.dart';
import 'package:proyect_atenea/src/domain/entities/user_entity.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button_v2.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_field.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_password_field.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_scaffold.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/user_provider.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/session_provider.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColors.grayColor,
      textColor: AppColors.ateneaWhite,
      fontSize: 16.0,
    );
  }

  Future<void> _login(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final sessionProvider = Provider.of<SessionProvider>(context, listen: false);

    final username = _usernameController.text;
    final password = _passwordController.text;

    try {
      UserEntity? user = await userProvider.loginUser(username, password);

      if (user != null) {
        // Crear una nueva sesión para el usuario autenticado
        SessionEntity session = SessionEntity(
          token: user.id, // Usa el ID del usuario como token de ejemplo
          userId: user.id,
          userName: user.fullName,
          userPermissions: user.userPermissions,
          tokenValidUntil: DateTime.now().add(const Duration(days: 7)), // Por ejemplo, 7 días de validez
        );

        // Guardar la sesión en el SessionProvider
        await sessionProvider.saveSession(session);

        _showToast('Inicio de sesión exitoso');
        
        Navigator.pushReplacementNamed(context, '/home'); // Redirige a la página principal
      } else {
        _showToast('Credenciales incorrectas');
      }
    } catch (e) {
      _showToast('Error al iniciar sesión');
      print('Error al iniciar sesión: $e');
    }
  }

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
              'Bienvenido de vuelta',
              textAlign: TextAlign.center,
              style: AppTextStyles.builder(
                color: AppColors.primaryColor,
                size: FontSizes.h1,
                weight: FontWeights.semibold,
              ),
            ),
            
             const Spacer(),
            Text(
              'Inicia Sesión',
              style: AppTextStyles.builder(
                color: AppColors.secondaryColor,
                size: FontSizes.h3,
              ),
            ),
            const SizedBox(height: 20),
            AteneaField(
              placeHolder: 'Ejemplo: Fernando',
              inputNameText: 'Usuario',
              controller: _usernameController, 
            ),
            const SizedBox(height: 10),
            AteneaPasswordField(
              placeHolder: 'Ejemplo: ******',
              inputNameText: 'Contraseña',
              controller: _passwordController,  
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                    child : AteneaButtonV2(
                      shouldLoad: true,
                      text: 'Iniciar',
                      onPressed: () => _login(context),
                    )
                  ),
              ],
            ),
             const Spacer(),
            Text(
              '¿Eres nuevo por acá?, ¡Regístrate!',
              textAlign: TextAlign.center,
              style: AppTextStyles.builder(
                color: AppColors.primaryColor,
                size: FontSizes.body2,
                weight: FontWeights.semibold,
              ),
            ),
            const SizedBox(height: 10),
            AteneaButtonV2(
              btnStyles: const AteneaButtonStyles(
                backgroundColor: AppColors.secondaryColor,
                textColor: AppColors.ateneaWhite,
              ),
              text: 'Regístrate',
              onPressed: () {
                Navigator.pushNamed(context, '/auth/register');
              },
            ),
          ],
        ),
      ),
    );
  }
}
