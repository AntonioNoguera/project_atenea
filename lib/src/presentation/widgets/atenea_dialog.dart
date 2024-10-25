  import 'package:flutter/material.dart';
  import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
  import 'package:proyect_atenea/src/presentation/widgets/atenea_button.dart';

  //In order to send only the button styles
  class AteneaButtonStyles {
    final Color backgroundColor;
    final Color textColor;

    AteneaButtonStyles({
      required this.backgroundColor,
      required this.textColor,
    });
  }

  //In order to got the callbacks well defined
  class AteneaButtonCallback {
    final String textButton;
    final VoidCallback onPressedCallback;
    final AteneaButtonStyles buttonStyles;

    AteneaButtonCallback({
      required this.textButton,
      required this.onPressedCallback,
      AteneaButtonStyles? buttonStyles,
    }) : buttonStyles = buttonStyles ??
              AteneaButtonStyles(
                backgroundColor: AppColors.primaryColor,
                textColor: AppColors.ateneaWhite,
              );
  }

  // Dialog that generates buttons dynamically
  class AteneaDialog extends StatelessWidget {
    final String title;
    final Widget content;
    final List<AteneaButtonCallback> buttonCallbacks;

    const AteneaDialog({
      super.key,
      required this.title,
      required this.content,
      required this.buttonCallbacks,
    });

    @override
    Widget build(BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          style: AppTextStyles.builder(
            color: AppColors.primaryColor,
            size: FontSizes.h4,
          ),
          textAlign: TextAlign.center,
        ),
        content:  content,
        actions: <Widget>[
            Container(
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 8.0, // Espaciado horizontal entre botones
                runSpacing: 4.0, // Espaciado vertical si se envuelven los botones
                children: buttonCallbacks.map((callback) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: AteneaButton(
                      text: callback.textButton,
                      backgroundColor: callback.buttonStyles.backgroundColor,
                      onPressed: callback.onPressedCallback,
                      textStyle: AppTextStyles.builder(
                        color: callback.buttonStyles.textColor,
                        size: FontSizes.body2,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],

      );
    }
  }
