import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proyect_atenea/src/domain/entities/shared/enum_fixed_values.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';

class UserContributorsPermitRow extends StatelessWidget {
  final List<Permits> userPermits;
  final Color svgTint;

  const UserContributorsPermitRow({
    super.key,
    this.userPermits = const [Permits.view],
    this.svgTint = AppColors.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          if (userPermits.contains(Permits.view))
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: SvgPicture.asset(
                'assets/svg/add_user.svg',
                width: 24,
                height: 24,
                color: svgTint,
              ),
            ),

          if (userPermits.contains(Permits.view))
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: SvgPicture.asset(
                'assets/svg/edit.svg',
                width: 24,
                height: 24,
                color: svgTint,
              ),
            ),

          if (userPermits.contains(Permits.view))
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: SvgPicture.asset(
                'assets/svg/trashcan.svg',
                width: 24,
                height: 24,
                color: svgTint,
              ),
            ),
        ],
      ),
    );
  }
}
