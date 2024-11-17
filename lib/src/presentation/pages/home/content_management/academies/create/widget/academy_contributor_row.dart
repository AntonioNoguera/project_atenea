import 'package:flutter/material.dart';
import 'package:proyect_atenea/src/domain/entities/shared/atomic_permission_entity.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_atomic_permits_row.dart';

class AcademyContributorRow extends StatelessWidget {
  final int index;
  final String contributorName;
  final AtomicPermissionEntity permissionEntity;
  final VoidCallback showDetail; // Callback para manejar el evento onClose

  const AcademyContributorRow({
    super.key,
    required this.contributorName,
    required this.permissionEntity,
    required this.index,
    required this.showDetail,
  });

  @override
  Widget build(BuildContext context) {
    const backgroundStyleVariations = [AppColors.primaryColor, AppColors.lightSecondaryColor];
    const fontStyleVariations = [AppColors.ateneaWhite, AppColors.primaryColor];

    var backgroundColor = backgroundStyleVariations[index % 2];
    var textColor = fontStyleVariations[index % 2];

    // Ajustar el peso basado en el color
    FontWeight textWeight = textColor == AppColors.primaryColor
        ? FontWeights.bold
        : FontWeights.regular;

    return ElevatedButton(
      onPressed: showDetail,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        margin: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                contributorName,
                style: AppTextStyles.builder(
                  color: textColor,
                  weight: textWeight,
                  size: FontSizes.body2,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            AteneaAtomicPermitsRow(
              permissionEntity: permissionEntity,
              color: textColor,
            ),
          ],
        ),
      ),
    );
  }
}
