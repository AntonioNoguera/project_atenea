import 'package:flutter/material.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button_v2.dart';

//In order to send only the button styles
class AteneaButtonStyles {
  final Color backgroundColor;
  final Color textColor;
  final bool hasBorder;

  const AteneaButtonStyles({
    required this.backgroundColor,
    required this.textColor,
    this.hasBorder = false,
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
            const AteneaButtonStyles(
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
    final double screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: screenWidth * 0.9, // 90% de la pantalla
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: AppTextStyles.builder(
                  color: AppColors.primaryColor,
                  size: FontSizes.h4,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              content,
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: buttonCallbacks.map((callback) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: AteneaButtonV2(
                        text: callback.textButton,
                        btnStyles: callback.buttonStyles,
                        onPressed: callback.onPressedCallback,
                        textStyle: AppTextStyles.builder(
                          color: callback.buttonStyles.textColor,
                          size: FontSizes.body2,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
