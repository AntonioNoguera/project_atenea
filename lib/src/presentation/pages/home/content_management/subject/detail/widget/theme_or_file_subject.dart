import 'package:flutter/material.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/subject/detail/widget/member_row.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';

class ThemeOrFileSubject extends StatelessWidget {
  final String contentType;
  final bool hasSvg;
  final List<String> content;

  ThemeOrFileSubject({
    super.key,
    this.contentType = '',
    this.hasSvg = false,
    required this.content,
  });

  final List<Color> memberStyle = [AppColors.lightSecondaryColor, AppColors.primaryColor];
  final List<Color> memberTextColor = [AppColors.ateneaWhite, AppColors.primaryColor];

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
              weight: FontWeights.semibold,
            ),
          ),
        ),
        const SizedBox(height: 7),
        SizedBox(
          height: 200, // Ajusta este tamaño según tus necesidades o usa Expanded si está en una Column
          child: ListView.builder(
            itemCount: content.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: MemberRow(
                  textColor: memberTextColor[index % 2],
                  backgroundColor: memberStyle[(index + 1) % 2],
                  hasSvg: hasSvg,
                  contentType: content[index], // Usa el contenido de `content`
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
