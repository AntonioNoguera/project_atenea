 import 'package:flutter/material.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/departments/academic_department_detail_page.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_page_animator.dart';


class AcademicDepartmentItemRow extends StatelessWidget {
  const AcademicDepartmentItemRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.ateneaWhite,
            elevation: 9.0,
            padding: const EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          onPressed: () { 
            Navigator.push(
              context,
              AteneaPageAnimator(page: AcademicDepartmentDetailPage())
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              
              Container(
                height: 45.0,
                decoration: const BoxDecoration(
                  color: Colors.brown,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric( horizontal: 16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 8.0,),
                    Text(
                      'Temas Selectos de Materia Genérica',
                      style: AppTextStyles.builder(
                        color: AppColors.ateneaBlack,
                        size: FontSizes.body1,
                        weight: FontWeights.semibold,
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      height: 1.0,
                      width: double.infinity,
                      color: AppColors.grayColor.withOpacity(.1),
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Autor',
                                style: AppTextStyles.builder(
                                  color: AppColors.primaryColor,
                                  size: FontSizes.body2,
                                ),
                              ),
                              Text(
                                'Noguera Guzman',
                                style: AppTextStyles.builder(
                                  color: AppColors.grayColor,
                                  size: FontSizes.body2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Academias disponibles',
                              style: AppTextStyles.builder(
                                color: AppColors.primaryColor,
                                size: FontSizes.body2,
                              ),
                            ),
                            Text(
                              '12',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.builder(
                                color: AppColors.grayColor,
                                size: FontSizes.body2,
                              ),
                            ),
                          ],
                        ), 
                      ],
                    ),
                    
                    const SizedBox(height: 16.0,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}