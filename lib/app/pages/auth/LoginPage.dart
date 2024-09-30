import 'package:flutter/material.dart'; 
 
import '../../widgets/AteneaScaffold.dart';
  

import '../../../app/values/AppTheme.dart'; 
 
import '../../widgets/AteneaField.dart';
import '../../widgets/AtenaDropDown.dart';
import '../../widgets/AteneaButton.dart'; 
import '../../widgets/AteneaSwitch.dart'; 

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
 
  @override
  Widget build(BuildContext context) {     

    return AteneaScaffold( 
          body : Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
              vertical: 50.0
              ),
            
            child: Column(  
              children: [
                Text(
                  "Bienvenido de vuelta", 
                  textAlign: TextAlign.center, 
                  style: AppTextStyles.builder(
                    color: AppColors.primaryColor, 
                    size: FontSizes.h1, 
                    weight: FontWeights.semibold
                  )
                ),
                
                const SizedBox(height: 60),
                
                Text("Inicia Sesión", style: AppTextStyles.builder(color: AppColors.secondaryColor, size: FontSizes.h3)), 

                const SizedBox(height: 30),
                
                const AteneaField(
                  placeHolder: "Ejemplo: Fernando",   
                  inputNameText:  "Usuario",
                ),

                const SizedBox(height: 10),

                const AteneaField(
                  placeHolder: "Ejemplo: Fernando",   
                  inputNameText:  "Contraseña"
                ),

                AteneaSwitch() ,

                const SizedBox(height:20) ,
 
                AteneaButton(
                  text: "Iniciar",
                  onPressed: () {  }
                ),

                const Spacer(),

                Text(
                  "¿Eres nuevo por acá?, ¡Regístrate!", 
                  textAlign: TextAlign.center, 
                  style: AppTextStyles.builder(
                    color: AppColors.primaryColor, 
                    size: FontSizes.body2, 
                    weight: FontWeights.semibold
                  )
                ),

                const SizedBox(height: 10,),

                AteneaButton(
                  backgroundColor: AppColors.secondaryColor,
                  text: "Regístrate", 
                  onPressed: () {}
                       
                ), 
              ]
            ), 
        )  
      
    );
  }
}