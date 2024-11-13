import 'package:flutter/material.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/subject/home_item_row.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart'; 
import 'package:proyect_atenea/src/presentation/widgets/atenea_button_v2.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_scaffold.dart';

class MySubjectsPage extends StatelessWidget {
  const MySubjectsPage({super.key});
 
  @override
  Widget build(BuildContext context) {     
    return AteneaScaffold( 
      body : Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 50.0
          ),
        
        child: Column( 
          children: [
            Text(
                'Mis Materias',
                style: AppTextStyles.builder(
                      color: AppColors.primaryColor, 
                      size: FontSizes.h2, 
                      weight: FontWeights.semibold
                    )
              ),

            const SizedBox(height: 20.0,),

            Padding(padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,),
              child: AteneaButtonV2(
                text : 'Añadir Nueva Materia',
                xpndText : true,

                svgIcon : SvgButtonStyle(
                  svgPath: 'assets/svg/add.svg' 
                ), 
                
                onPressed: () {
                  print('Pressed');
                }
              ),
            ),
            

            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric( 
                    vertical: 20.0,
                    horizontal: MediaQuery.of(context).size.width * 0.05,),
                  
                  child: const Column(
                    /*
                    Todo, get Saved Subjects
                    
                    children: List.generate(30, (index) {
                      return const HomeSubject();
                    })
                    */
                  )
                )
              )
            )
          ] 
        )
      ),
    );
  }
}