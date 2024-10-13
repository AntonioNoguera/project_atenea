import 'package:flutter/material.dart';

import 'package:proyect_atenea/src/presentation/pages/home/content_management/departments/academic_department_item_row.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_scaffold.dart';


class AcademyCreateNewPage extends StatelessWidget {

  const AcademyCreateNewPage({super.key}); 

  @override
  Widget build(BuildContext context) {

    return AteneaScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 30.0,
        ),
        child: Stack(
          children: [
            Column(
              children: [
                
                const SizedBox(height: 10.0,),
                
                Text(
                  'Nueva Academia',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.builder(
                    color: AppColors.primaryColor,
                    size: FontSizes.h3,
                    weight: FontWeights.semibold,
                  ),
                ),
                
                const SizedBox(height: 45.0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}