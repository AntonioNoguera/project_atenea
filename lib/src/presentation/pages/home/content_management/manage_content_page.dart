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
  bool isButtonCollapsed = false;
  ScrollController _scrollController = ScrollController();

  final Map<int, Widget> _renderedContent = {
    0: Column(
      children: [
        Column(
          children: List.generate(8, (index) {
            return HomeSubject();
          }),
        )
      ],
    ),
    1: Column(
          children: List.generate(8, (index) {
            return HomeSubject();
          }),
        )
     
  };

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
          vertical: 30.0,
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
                    textAlign: TextAlign.center,
                    'Posees un super usuario, te permitirá editar tanto academias, como departamentos académicos',
                    style: AppTextStyles.builder(
                      color: AppColors.primaryColor,
                      size: FontSizes.body2,
                      weight: FontWeights.regular,
                    ),
                    ),
                const SizedBox(height: 20),
                ToggleButtonsWidget(
                  onToggle: _handleToggle,
                  toggleOptions: toggleOptions,
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        _renderedContent[activeIndex] ?? const Text('Unrenderable'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40.0),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AnimatedContainer(
                        curve: Curves.decelerate,
                        duration: Duration(milliseconds: 230),
                        width: isButtonCollapsed ? 60.0 : 200.0,
                        child: AteneaButton(
                          padding : EdgeInsets.symmetric(vertical: 12.0, horizontal: 0),
                          text: isButtonCollapsed ? null : 'Crear Acadermia',
                          iconSize: 30.0,
                          svgIcon: 'assets/svg/add.svg',
                          svgTint: AppColors.primaryColor,
                          enabledBorder: true,
                          backgroundColor: AppColors.ateneaWhite,
                          textStyle: AppTextStyles.builder(color: AppColors.primaryColor, size: FontSizes.body1),
                          onPressed: () {
                            Navigator.pop(context);
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
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
