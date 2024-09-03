import 'package:flutter/material.dart'; 

import '../common/widgets/AteneaField.dart';
import '../common/widgets/AteneaScaffold.dart';

import '../common/widgets/AteneaBackground.dart';
import '../core/utils/AppTheme.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AteneaScaffold(
      body: AteneaBackground(
        child: Center(
          child: SafeArea(
            minimum: EdgeInsets.all(MediaQuery.of(context).size.width*.15),
            child: const AteneaField(
              placeHolder: "Ejemplo: Fernando", 
              inputNameText:  "Ingresa el Usuario"
              )
          )  
        ),
      ),
    );
  }
}