import 'package:flutter/material.dart'; 
import 'package:provider/provider.dart';
import 'package:proyect_atenea/src/domain/entities/session_entity.dart';
import 'package:proyect_atenea/src/presentation/pages/home/profile/my_profile_page.dart';
import 'package:proyect_atenea/src/presentation/pages/home/pinned_subjects/my_subjects_page.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/session_provider.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_scaffold.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SessionEntity>(
      future: _loadSession(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error al cargar la sesión'));
        } else {
          final session = snapshot.data ?? SessionEntity.defaultValues();
          return _buildHomePage(context, session);
        }
      },
    );
  }

  Future<SessionEntity> _loadSession(BuildContext context) async {
    final SessionProvider sessionProvider =
        Provider.of<SessionProvider>(context, listen: false);
    await sessionProvider.loadSession();

    SessionEntity? session = await sessionProvider.getSession();
    return session ?? SessionEntity.defaultValues();
  }

  Widget _buildHomePage(BuildContext context, SessionEntity session) {
    int selectedIndex = 0;

    void onItemTapped(int index) {
      selectedIndex = index;
    }

    final List<Widget> pages = [
      const MySubjectsPage(),
      MyProfilePage(session),
    ];

    return StatefulBuilder(
      builder: (context, setState) {
        return AteneaScaffold(
          body: Stack(
            children: <Widget>[
              IndexedStack(
                index: selectedIndex,
                children: pages,
              ),
              Positioned(
                left: 20,
                right: 20,
                bottom: 20,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(30), // Redondea los bordes
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
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
                        // Ajusta el cálculo considerando el padding
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          left: (MediaQuery.of(context).size.width - 40) /
                              2 *
                              selectedIndex, // Cálculo dinámico
                          top: 0, // Margen superior para centrado vertical
                          width: (MediaQuery.of(context).size.width /
                              2), // Ajustar el ancho del óvalo
                          height: 61, // Altura del óvalo
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.ateneaWhite
                                  .withOpacity(0.2), // Color translúcido
                              borderRadius: BorderRadius.circular(
                                  40), // Bordes redondeados para el óvalo
                            ),
                          ),
                        ),

                        BottomNavigationBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          selectedItemColor: AppColors.ateneaWhite,
                          unselectedItemColor:
                              AppColors.ateneaWhite.withOpacity(0.6),
                          currentIndex: selectedIndex,
                          onTap: (index) {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          type: BottomNavigationBarType.fixed,
                          items: const [
                            BottomNavigationBarItem(
                              icon: Icon(Icons.book, size: 27),
                              label: 'Mis Materias',
                            ),
                            BottomNavigationBarItem(
                              icon: Icon(Icons.account_circle, size: 27),
                              label: 'Mi Perfil',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}