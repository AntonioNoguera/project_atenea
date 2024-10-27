import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proyect_atenea/src/domain/entities/enum_fixed_values.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';


class AteneaPermitsRow extends StatelessWidget {
  final List<Permits> userPermits;

  const AteneaPermitsRow({
    super.key,
    this.userPermits = const [Permits.view],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center, // Centra el contenido tanto vertical como horizontalmente
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Centra horizontalmente los íconos en el Row
        children: [
          SizedBox(height: 6.0,),
          if (userPermits.contains(Permits.view))
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: SvgPicture.asset(
                'assets/svg/add_user.svg',
                width: 24,
                height: 24,
                color: AppColors.grayColor,
              ),
            ),
          if (userPermits.contains(Permits.view))
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: SvgPicture.asset(
                'assets/svg/edit.svg',
                width: 24,
                height: 24,
                color: AppColors.grayColor,
              ),
            ),
          if (userPermits.contains(Permits.view))
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: SvgPicture.asset(
                'assets/svg/trashcan.svg',
                width: 24,
                height: 24,
                color: AppColors.grayColor,
              ),
            ),
        ],
      ),
    );
  }
}
