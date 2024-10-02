import 'package:flutter/material.dart';
 
import 'package:proyect_atenea/app/values/AppTheme.dart';
import 'package:proyect_atenea/app/widgets/AteneaScaffold.dart'; 

class SubjectDetailPage extends StatelessWidget {
  const SubjectDetailPage({super.key});

  @override
  Widget build(BuildContext context) {

    return const AteneaScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text("Detalle de Materia"),
          ],
        ),
      ),
    );
  }
}

