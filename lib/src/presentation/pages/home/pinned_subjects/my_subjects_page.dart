import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proyect_atenea/src/presentation/pages/home/pinned_subjects/widgets/add_pinned_subject_dialog.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button_v2.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_card.dart';
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
              child: AddPinnedSubjectDialog()
              ), 
            Expanded(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05), // 10% de margen horizontal
                  child: AteneaCard(
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
                          'No tienes materias destacadas',
                          style: AppTextStyles.builder(
                            color: AppColors.ateneaBlack,
                            weight: FontWeights.semibold,
                            size: FontSizes.body1,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          'No hay ninguna materia destacada en tu lista de materias. Añade una nueva materia, podrás encontrarlas por acá.',
                          style: AppTextStyles.builder(
                            color: AppColors.textColor,
                            weight: FontWeights.regular,
                            size: FontSizes.body2,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
