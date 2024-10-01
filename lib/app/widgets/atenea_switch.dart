import 'package:flutter/material.dart';
import 'package:proyect_atenea/app/values/app_theme.dart';

class AteneaSwitch extends StatefulWidget {
  const AteneaSwitch({
    super.key,
  });

  @override
  State<AteneaSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<AteneaSwitch> {
  bool isSwitched = false; // Estado local del switch

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(isSwitched ? "Recuérdame" : "Cerrar sesión al salir", style: AppTextStyles.builder(color: AppColors.primaryColor, size: FontSizes.body1)),
        const SizedBox(width: 10),
        Switch(
            value: isSwitched,
            onChanged: (value) {
              setState(() {
                isSwitched = value; // Actualiza el estado local
              });
            },
            activeColor: AppColors.primaryColor,
            inactiveThumbColor: Colors.grey),
      ],
    );
  }
}
