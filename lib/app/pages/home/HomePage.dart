import 'package:flutter/material.dart';
import 'package:proyect_atenea/app/values/AppTheme.dart';
import 'package:proyect_atenea/app/widgets/AteneaScaffold.dart'; 

import 'package:proyect_atenea/app/pages/home/home_profile_pages/default_profile_page.dart';
import 'package:proyect_atenea/app/pages/home/my_subjects/my_subjects_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  
  final List<Widget> _pages = <Widget>[ 
    const MySubjectsPage(),
    const DefaultProfilePage(), 
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<String> _labels = ['Mis Materias', 'Mi Perfil'];
  //Note: Navbar still on working

  @override
  Widget build(BuildContext context) {
    return AteneaScaffold(
      body: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
      ),
      clipBehavior: Clip.hardEdge,
      child:
        Stack( 
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
                              icon: Icon(Icons.home),
                              label: _labels[0],
                            ),
                            BottomNavigationBarItem(
                              icon: Icon(Icons.person),
                              label: _labels[1],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                  )
                  ]
            )
      
            ),
          );
        
  }
}
