import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proyect_atenea/src/domain/entities/shared/enum_fixed_values.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';

class AteneaPermitsRow extends StatelessWidget {
  final List<PermitTypes> userPermits;

  const AteneaPermitsRow({
    super.key,
    this.userPermits = const [PermitTypes.edit],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center, 
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, 
        children: [
          const SizedBox(height: 6.0,), 

          if (userPermits.contains(PermitTypes.edit))
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: SvgPicture.asset(
                'assets/svg/add_user.svg',
                width: 24,
                height: 24,
                color: AppColors.grayColor,
              ),
            ),
          if (userPermits.contains(PermitTypes.edit))
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: SvgPicture.asset(
                'assets/svg/edit.svg',
                width: 24,
                height: 24,
                color: AppColors.grayColor,
              ),
            ),
          if (userPermits.contains(PermitTypes.edit))
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
