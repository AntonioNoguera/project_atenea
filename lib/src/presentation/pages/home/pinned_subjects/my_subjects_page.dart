import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button_v2.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_scaffold.dart';

class MySubjectsPage extends StatelessWidget {
  const MySubjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AteneaScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 50.0,
        ),
        child: Column(
          children: [
            Text(
              'Mis Materias',
              style: AppTextStyles.builder(
                color: AppColors.primaryColor,
                size: FontSizes.h2,
                weight: FontWeights.semibold,
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
              ),
              child: AteneaButtonV2(
                text: 'Añadir Nueva Materia',
                xpndText: true,
                svgIcon: SvgButtonStyle(
                  svgPath: 'assets/svg/add.svg',
                ),
                onPressed: () {
                  print('Pressed');
                },
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/svg/crossed_folder.svg',
                      height: 50,
                      width: 50,
                      color: AppColors.grayColor.withOpacity(0.9),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      'No tienes materias guardadas',
                      style: AppTextStyles.builder(
                        color: AppColors.grayColor.withOpacity(0.9),
                        weight: FontWeights.regular,
                        size: FontSizes.h5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
