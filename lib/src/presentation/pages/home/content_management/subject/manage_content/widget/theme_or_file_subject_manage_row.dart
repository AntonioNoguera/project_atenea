import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proyect_atenea/src/domain/entities/enum_fixed_values.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';

class ThemeOrFileSubjectManageRow extends StatelessWidget {
  final String content;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final int index;
 
  const ThemeOrFileSubjectManageRow({
    super.key,
    required this.content,
    required this.onEdit,
    required this.onDelete,
    required this.index,  
  });

  @override
  Widget build(BuildContext context) {

    var backgroundColor = AteneaRowStyleValues.values[AteneaRowStyles.backgroundStyle]![index % 2];
    var textColor = AteneaRowStyleValues.values[AteneaRowStyles.fontStyle]![index % 2];

    return Container(
      key: ValueKey(content),
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),
      decoration: BoxDecoration(
        color: backgroundColor,  
        borderRadius: BorderRadius.circular(12.0),  
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 10.0, right: 13.0),
        title: Row(
          children: [
            Expanded(
              child: Text(
                content,
                style: AppTextStyles.builder(
                  size: FontSizes.body2,
                  weight: index % 2 != 0 ? FontWeights.semibold : FontWeights.regular, 
                  color: textColor, 
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.edit, color: textColor),
              onPressed: onEdit,
            ),
            IconButton(
              icon: Icon(Icons.delete, color: textColor),
              onPressed: onDelete,
            ),
            ReorderableDragStartListener(
              index: index,
              child: SvgPicture.asset(
                'assets/svg/drag_indicator.svg', 
                height: 20,
                width: 20,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}