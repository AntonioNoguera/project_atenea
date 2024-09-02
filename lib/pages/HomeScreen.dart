import 'package:flutter/material.dart';
import '../core/utils/widgets/AteneaButton.dart';

import '../core/utils/widgets/AteneaScaffold.dart';

import '../core/utils/widgets/AteneaBackground.dart';
import '../core/utils/AppTheme.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const AteneaScaffold(
      body: AteneaBackground(
        child: Center(
          child: SafeArea(
            child: 

          //pending on the aousiderMember
           TextField(
            style: TextStyle(
              fontFamily: 'RadioCanada',
              color: Colors.red,
              fontSize: 26.0,
            ),
            decoration: InputDecoration(
              labelText: 'Username',
              labelStyle: TextStyle(
                fontFamily: 'RadioCanada',
                color: Color.fromARGB(255, 0, 5, 35), // Aquí estableces el color del texto del label
                fontSize: 26.0,
              ),
              hintText: 'Enter your username',
              // Borde que se muestra cuando el TextField está habilitado y no en foco
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.green, // Color del borde por defecto
                  width: 2.0,
                ),
              ),
              // Borde que se muestra cuando el TextField está en foco
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 239, 187, 184), // Color del borde cuando el campo está enfocado
                  width: 4.5,
                ),
              ),
              // Borde que se muestra cuando el TextField está deshabilitado
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black, // Color del borde cuando el campo está deshabilitado
                  width: 2.0,
                ),
              ),
              // Borde que se muestra cuando hay un error de validación
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red, // Color del borde en estado de error
                  width: 2.0,
                ),
              ),
              // Borde que se muestra cuando el campo está enfocado y hay un error
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.redAccent, // Color del borde cuando está enfocado y hay un error
                  width: 2.5,
                ),
              ),
            ),
          )

          )  
        ),
      ),
    );
  }
}