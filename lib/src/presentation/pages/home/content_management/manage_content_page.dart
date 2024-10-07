import 'package:flutter/material.dart';
import 'package:proyect_atenea/src/presentation/pages/home/my_subects/widgets/home_subject.dart';
import 'package:proyect_atenea/src/presentation/widgets/toggle_buttons_widget%20.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_scaffold.dart';

class ManageContentPage extends StatefulWidget {
  const ManageContentPage({super.key});

  @override
  _ManageContentPageState createState() => _ManageContentPageState();
}

class _ManageContentPageState extends State<ManageContentPage> {
  int activeIndex = 0;

  final Map<int, Widget> _renderedContent = {
    0: Column(
      children: [
        
        AteneaButton(
          text: 'Agregar nueva academia',
          onPressed: () {

          }
        ),

        const SizedBox(height: 20.0,),

        Column(
          children:  List.generate(8, (index) {
            return HomeSubject();
          }),
        ) 
      
      ],
    ),
    1: Column(
      children: [
        
        AteneaButton(
          text: 'Agregar nueva academia',
          onPressed: () {

          }
        ),

        Column(
          children:  List.generate(8, (index) {
            return HomeSubject();
          }),
        ) 
      
      ],
    ),
  };

  void _handleToggle(int index) {
    setState(() {
      activeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> toggleOptions = ['Academias (3)', 'Departamentos (1)'];

    return AteneaScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: 50.0,
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Text(
                  'Administrar Contenidos',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.builder(
                    color: AppColors.primaryColor,
                    size: FontSizes.h3,
                    weight: FontWeights.semibold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                    'Posees un super usuario, te permitirá editar tanto academias, como departamentos académicos'),
                const SizedBox(height: 20),
                ToggleButtonsWidget(
                  onToggle: _handleToggle,
                  toggleOptions: toggleOptions,
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        _renderedContent[activeIndex] ?? const Text('Unrenderable'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40.0,)
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Row(
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
            ),
          ],
        ),
      ),
    );
  }
}
