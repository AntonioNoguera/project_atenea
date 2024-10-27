import 'package:flutter/material.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/subject/detail/widget/member_row.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';

class ThemeOrFileSubject extends StatelessWidget {
  final String contentType;

  final bool hasSvg;

  ThemeOrFileSubject({
    super.key,
    this.contentType = '',
    this.hasSvg = false,
  });

  final List<Color> memberStyle  = [AppColors.lightSecondaryColor, AppColors.primaryColor];
  final List<Color> memberTextColor  = [AppColors.ateneaWhite, AppColors.primaryColor];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            contentType,
            textAlign: TextAlign.center,
            style: AppTextStyles.builder(
              color: AppColors.primaryColor,
              size: FontSizes.h4,
              weight: FontWeights.semibold
            ),
          ),
        ),
        const SizedBox(height: 7),
        Column(
          children: List.generate(12, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: MemberRow(
                textColor: memberTextColor[index%2],
                backgroundColor: memberStyle[(index +1 )%2],
                hasSvg : hasSvg,
                contentType: 'Item $index'),
            );
          }),
        ),
      ],
    );
  }
}
