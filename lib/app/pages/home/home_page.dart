import 'package:flutter/material.dart';
import 'package:proyect_atenea/app/values/app_theme.dart';
import 'package:proyect_atenea/app/widgets/atenea_scaffold.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = <Widget>[
    const Center(child: Text('Mis Unidades', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Mi Perfil', style: TextStyle(fontSize: 24))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Lista de etiquetas para facilitar la alineación del fondo
  final List<String> _labels = ['Home', 'Profile'];

  @override
  Widget build(BuildContext context) {
    return AteneaScaffold(
      body: Stack(
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
                borderRadius: BorderRadius.circular(30), // Bordes redondeados
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5), // Sombra debajo
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Fondo personalizado para el ítem seleccionado
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
                      width: MediaQuery.of(context).size.width / 2 - 20, // Ajusta según el número de ítems
                      decoration: BoxDecoration(
                        color: AppColors.ateneaWhite.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  BottomNavigationBar(
                    backgroundColor: Colors.transparent, // Hacer transparente para ver el fondo personalizado
                    elevation: 0,
                    selectedItemColor: AppColors.ateneaWhite,
                    unselectedItemColor: AppColors.ateneaWhite.withOpacity(0.6),
                    currentIndex: _selectedIndex, // Índice del ítem seleccionado
                    onTap: _onItemTapped, // Manejar el toque en los ítems
                    type: BottomNavigationBarType.fixed,
                    items: [
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.home),
                        label: _labels[0],
                      ),
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.person),
                        label: _labels[1],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
