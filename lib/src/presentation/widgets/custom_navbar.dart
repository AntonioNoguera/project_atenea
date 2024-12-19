import 'package:flutter/material.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: const EdgeInsets.all(20),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem(
            context,
            index: 0,
            icon: Icons.book,
            label: 'Mis Materias',
          ),
          _buildNavItem(
            context,
            index: 1,
            icon: Icons.account_circle,
            label: 'Mi Perfil',
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context,
      {required int index, required IconData icon, required String label}) {
    final bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 27,
            color: isSelected
                ? AppColors.ateneaWhite
                : AppColors.ateneaWhite.withOpacity(0.6),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected
                  ? AppColors.ateneaWhite
                  : AppColors.ateneaWhite.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}
