import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';

class AcademyContributorRow extends StatelessWidget {
  final int index;
  final String content;

  const AcademyContributorRow({
    super.key,
    required this.content,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {

    const backgroundStyleVariations = [AppColors.primaryColor , AppColors.lightSecondaryColor];
    const fontStyleVariations = [AppColors.ateneaWhite , AppColors.primaryColor];

    var backgroundColor = backgroundStyleVariations[ index % 2 ];
    var textColor = fontStyleVariations[ index % 2];

    return Container(
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
              content,
              style: AppTextStyles.builder(
                  color: textColor,
                  weight: FontWeights.regular,
                  size: FontSizes.body2),
            ),
          ),

          const SizedBox(width: 10.0),
          
          SvgPicture.asset(
            'assets/svg/close.svg',
            color: textColor,
            height: 22.0,
            width: 22.0,
          ),

        ],
      ),
    );
  }
}
