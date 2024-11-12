import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
    final SessionProvider sessionProvider = Provider.of<SessionProvider>(context, listen: false);
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
          body: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
            ),
            clipBehavior: Clip.hardEdge,
            child: Stack(
              children: <Widget>[
                IndexedStack(
                  index: selectedIndex,
                  children: pages,
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
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          left: selectedIndex == 0 ? 0 : null,
                          right: selectedIndex == 1 ? 0 : null,
                          top: 0,
                          bottom: 0,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
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
                          currentIndex: selectedIndex,
                          onTap: (index) {
                            setState(() {
                              onItemTapped(index);
                            });
                          },
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
      },
    );
  }
}