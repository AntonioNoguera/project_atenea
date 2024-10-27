import 'package:flutter/material.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/academies/create/academy_create_new_page.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/academies/academy_item_row.dart'; 
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_card.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_page_animator.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_scaffold.dart';

class AcademicDepartmentDetailPage extends StatefulWidget {
  const AcademicDepartmentDetailPage({super.key});

  @override
  _AcademicDepartmentDetailPageState createState() => _AcademicDepartmentDetailPageState();
}

class _AcademicDepartmentDetailPageState extends State<AcademicDepartmentDetailPage> {
  int activeIndex = 0;
  bool isButtonCollapsed = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 50 && !isButtonCollapsed) {
        setState(() {
          isButtonCollapsed = true;
        });
      } else if (_scrollController.offset <= 50 && isButtonCollapsed) {
        setState(() {
          isButtonCollapsed = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AteneaScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric( vertical: 30.0, ),
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 10.0,),
                Text(
                  'Informática',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.builder(
                    color: AppColors.primaryColor,
                    size: FontSizes.h3,
                    weight: FontWeights.semibold,
                  ),  
                ),
                const SizedBox(height: 10),
                Text(
                  'Posees un super usuario, te permitirá editar tanto academias, como departamentos académicos, prueba entrando a un departamento académico.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.builder(
                    color: AppColors.primaryColor,
                    size: FontSizes.body2,
                    weight: FontWeights.regular,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  textAlign: TextAlign.center,
                  'Departamentos Académicos Disponibles',
                  style: AppTextStyles.builder(  
                    color: AppColors.primaryColor.withOpacity(.8),
                    size: FontSizes.h5,
                    weight: FontWeights.semibold,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child:
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05,),
                      child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                         AteneaCard(
                            child:Column(
                              children: [
                                Text(
                                  'Redactado por:',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.builder(
                                    color: AppColors.ateneaBlack,
                                    size: FontSizes.body1,
                                    weight: FontWeights.semibold,
                                  ),
                                ),
                                Text(
                                  'Michael Antonio Noguera Guzmán',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.builder(
                                    color: AppColors.grayColor,
                                    size: FontSizes.body2,
                                    weight: FontWeights.regular,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'Última Actualización:',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.builder(
                                    color: AppColors.ateneaBlack,
                                    size: FontSizes.body1,
                                    weight: FontWeights.semibold,
                                  ),
                                ),
                                Text(
                                  '23 Sep 2024 | 15:20',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.builder(
                                    color: AppColors.grayColor,
                                    size: FontSizes.body2,
                                    weight: FontWeights.regular,
                                  ),
                                ),
                              ]
                            )
                          ),
                          
                          SizedBox(height: 20.0,),
                          Column(
                            children: List.generate(20, (index) {
                              return AcademyItemRow();
                            }),
                          ), 
                        ],
                      ),
                    )
                  ),
                ),
                
                const SizedBox(height: 45.0),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                children: [
                 Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AnimatedContainer(
                        curve: Curves.decelerate,
                        duration: const Duration(milliseconds: 230),
                        width: isButtonCollapsed ? 60.0 : 200.0,
                        child: AteneaButton(
                          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 0),
                          text: isButtonCollapsed ? null : 'Crear Academia',
                          iconSize: 30.0,
                          svgIcon: 'assets/svg/add.svg',
                          svgTint: AppColors.primaryColor,
                          enabledBorder: true,
                          backgroundColor: AppColors.ateneaWhite,
                          textStyle: AppTextStyles.builder(color: AppColors.primaryColor, size: FontSizes.body1),
                          onPressed: () {
                            Navigator.push(
                              context, 
                              
                              AteneaPageAnimator(page: AcademyCreateNewPage()) );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: AteneaButton(
                          text: 'Volver',
                          backgroundColor: AppColors.secondaryColor,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ) 
               
            ),
          ],
        ),
      ),
    );
  }
}
