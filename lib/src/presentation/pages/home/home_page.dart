import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proyect_atenea/src/domain/entities/enum_fixed_values.dart';
import 'package:proyect_atenea/src/domain/entities/session_entity.dart';
import 'package:proyect_atenea/src/presentation/pages/home/profile/my_profile_page.dart';
import 'package:proyect_atenea/src/presentation/pages/home/my_subects/my_subjects_page.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_scaffold.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late SessionEntity mock;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    
    // Inicializa el mock y la lista de páginas aquí
    mock = SessionEntity(token: 'token', userId: 'userId', userPermissions: [], tokenValidUntil: DateTime.now());

    _pages = <Widget>[
      const MySubjectsPage(),
      MyProfilePage(mock), // Ahora puedes usar 'mock' correctamente
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //Note: Navbar still on working
  @override
  Widget build(BuildContext context) {
    return AteneaScaffold(
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: <Widget>[
            IndexedStack(
              index: _selectedIndex,
              children: _pages,
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 5000),
                      curve: Curves.easeInOut,
                      left: _selectedIndex == 0 ? 0 : null,
                      right: _selectedIndex == 1 ? 0 : null,
                      top: 0,
                      bottom: 0,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 5000),
                        curve: Curves.easeInOut,
                        width: MediaQuery.of(context).size.width / 2 - 20,
                        decoration: BoxDecoration(
                          color: AppColors.ateneaWhite.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    BottomNavigationBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      selectedItemColor: AppColors.ateneaWhite,
                      unselectedItemColor: AppColors.ateneaWhite.withOpacity(0.6),
                      currentIndex: _selectedIndex,
                      onTap: _onItemTapped,
                      type: BottomNavigationBarType.fixed,
                      items: [
                        BottomNavigationBarItem(
                          icon: SvgPicture.asset(
                            'assets/svg/book.svg',
                            height: 27.0,
                            width: 27.0,
                          ),
                          label: 'Mis Materias',
                        ),
                        BottomNavigationBarItem(
                          icon: SvgPicture.asset(
                            'assets/svg/account.svg',
                            height: 27.0,
                            width: 27.0,
                          ),
                          label: 'Mi Perfil',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
