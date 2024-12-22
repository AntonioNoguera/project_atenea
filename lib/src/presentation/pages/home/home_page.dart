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
          return _HomePageBody(session: session);
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
}

class _HomePageBody extends StatelessWidget {
  final SessionEntity session;

  const _HomePageBody({required this.session});

  @override
  Widget build(BuildContext context) {
    return PageSelector(
      pages: [
        const MySubjectsPage(),
        MyProfilePage(session),
      ],
    );
  }
}

class PageSelector extends StatelessWidget {
  final List<Widget> pages;

  const PageSelector({required this.pages});

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ValueNotifier<int>(0);
    return ValueListenableBuilder<int>(
      valueListenable: selectedIndex,
      builder: (context, value, child) {
        return AteneaScaffold(
          body: Stack(
            children: <Widget>[
              IndexedStack(
                index: selectedIndex.value,
                children: pages,
              ),
              Positioned(
                left: 20,
                right: 20,
                bottom: 20,
                child: CustomNavigationBar(
                  selectedIndex: selectedIndex.value,
                  onItemTapped: (index) {
                    selectedIndex.value = index;
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
class CustomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const CustomNavigationBar({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
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
        child: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedIconTheme: IconThemeData(
                color: AppColors.ateneaWhite,
              ),
              unselectedIconTheme: IconThemeData(
                color: AppColors.ateneaWhite.withOpacity(0.6),
              ),
              selectedItemColor: AppColors.ateneaWhite,
              unselectedItemColor: AppColors.ateneaWhite.withOpacity(0.6),
              type: BottomNavigationBarType.fixed,
              
            ),
          ),
          child: Stack(
            children: [
              AnimatedIndicator(selectedIndex: selectedIndex),
              BottomNavigationBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                currentIndex: selectedIndex,
                onTap: onItemTapped,
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
    );
  }
}

class AnimatedIndicator extends StatelessWidget {
  final int selectedIndex;

  const AnimatedIndicator({required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      left: (MediaQuery.of(context).size.width - 40) / 2 * selectedIndex,
      top: 0,
      width: (MediaQuery.of(context).size.width / 2),
      height: 61,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.ateneaWhite.withOpacity(0.2),
          borderRadius: BorderRadius.circular(40),
        ),
      ),
    );
  }
}