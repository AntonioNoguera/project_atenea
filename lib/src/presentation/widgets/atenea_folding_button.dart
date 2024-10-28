import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_atenea/src/presentation/providers/app_state_providers/scroll_controller_notifier.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button.dart';
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
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AnimatedContainer(
              curve: Curves.decelerate,
              duration: const Duration(milliseconds: 230),
              width: scrollNotifier.isButtonCollapsed ? 60.0 : 200.0,
              child: AteneaButton(
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 0),
                text: scrollNotifier.isButtonCollapsed ? null : data,
                iconSize: 30.0,
                svgIcon: 'assets/svg/add.svg',
                svgTint: AppColors.primaryColor,
                enabledBorder: true,
                backgroundColor: AppColors.ateneaWhite,
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