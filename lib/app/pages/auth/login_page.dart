import 'package:flutter/material.dart';
import 'package:proyect_atenea/app/values/app_theme.dart';
import 'package:proyect_atenea/app/widgets/atenea_button.dart';
import 'package:proyect_atenea/app/widgets/atenea_field.dart';
import 'package:proyect_atenea/app/widgets/atenea_scaffold.dart';
import 'package:proyect_atenea/app/widgets/atenea_switch.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    super.key,
  });

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
              style: AppTextStyles.builder(color: AppColors.primaryColor, size: FontSizes.h1, weight: FontWeights.semibold),
            ),
            const SizedBox(height: 60),
            Text(
              'Inicia Sesión',
              style: AppTextStyles.builder(color: AppColors.secondaryColor, size: FontSizes.h3),
            ),
            const SizedBox(height: 30),
            const AteneaField(
              placeHolder: 'Ejemplo: Fernando',
              inputNameText: 'Usuario',
            ),
            const SizedBox(height: 10),
            const AteneaField(
              placeHolder: 'Ejemplo: Fernando',
              inputNameText: 'Contraseña',
            ),
            const AteneaSwitch(),
            const SizedBox(height: 20),
            AteneaButton(
              text: 'Iniciar',
              onPressed: () {},
            ),
            const Spacer(),
            Text(
              '¿Eres nuevo por acá?, ¡Regístrate!',
              textAlign: TextAlign.center,
              style: AppTextStyles.builder(color: AppColors.primaryColor, size: FontSizes.body2, weight: FontWeights.semibold),
            ),
            const SizedBox(
              height: 10,
            ),
            AteneaButton(
              backgroundColor: AppColors.secondaryColor,
              text: 'Regístrate',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
