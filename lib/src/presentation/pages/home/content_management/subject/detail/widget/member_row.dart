import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';

class MemberRow extends StatelessWidget {
  final String contentType;
  final Color backgroundColor;
  final Color textColor;
  final bool hasSvg;

  const MemberRow({
    super.key,
    required this.contentType,
    required this.backgroundColor,
    required this.textColor,
    this.hasSvg = false
  });

  @override
  Widget build(BuildContext context) {
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
              contentType,
              style: AppTextStyles.builder(color: textColor, weight: FontWeights.regular, size: FontSizes.body2),
            ),
          ),
          const SizedBox(width: 10.0),

          if(hasSvg)

            SvgPicture.asset(
              'assets/svg/view_file.svg',
              color : textColor,
              height: 22.0,
              width: 22.0,
            ),
        ],
      ),
    );
  }
}
