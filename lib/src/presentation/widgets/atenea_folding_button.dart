import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_atenea/src/presentation/providers/app_state_providers/scroll_controller_notifier.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/values/app_utils.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button_v2.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_page_animator.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/subject/create/subject_create_new_page.dart';



class AteneaFoldingButton extends StatelessWidget {
  final String data;
  final String svgIcon;
  final VoidCallback onPressedCallback;

  const AteneaFoldingButton (
      {
        super.key, 
        required this.data, 
        required this.svgIcon, 
        required this.onPressedCallback
      }
    );

  @override
  Widget build(BuildContext context) {
    return Consumer<ScrollControllerNotifier>(
      builder: (context, scrollNotifier, child) {
         final textStyle = AppTextStyles.builder(
          color: AppColors.primaryColor,
          size: FontSizes.body1,
        );

        final textWidth = calculateTextWidth(data, textStyle); // Usa el método de utilidades


        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AnimatedContainer(
              curve: Curves.decelerate,
              duration: const Duration(milliseconds: 230),
              width: scrollNotifier.isButtonCollapsed ? 60.0 : textWidth +  80, // Ajusta el ancho en base al texto
              child: AteneaButtonV2(
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 0),
                text: scrollNotifier.isButtonCollapsed ? null : data,
                
                svgIcon : SvgButtonStyle(
                  svgPath:  'assets/svg/add.svg', 
                  svgDimentions: 30.0
                ),

                btnStyles: const AteneaButtonStyles(
                  backgroundColor: AppColors.ateneaWhite, 
                  textColor: AppColors.primaryColor,
                  hasBorder : true,
                ),
                
                textStyle: AppTextStyles.builder(
                  color: AppColors.primaryColor,
                  size: FontSizes.body1,
                ),
                
                onPressed: onPressedCallback,
              ),
            ),
          ],
        );
      },
    );
  }
}