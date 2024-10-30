import 'package:flutter/material.dart';
import 'package:proyect_atenea/src/presentation/pages/home/my_subects/widgets/home_subject.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button.dart';
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
                      weight: FontWeights.regular
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
                  print("Pressed");
                }
              ),
            ),
            

            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric( 
                    vertical: 20.0,
                    horizontal: MediaQuery.of(context).size.width * 0.05,),
                  
                  child: Column(
                    children: List.generate(30, (index) {
                      return HomeSubject();
                    })
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