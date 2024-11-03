import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';

class AteneaBottomDialog extends StatelessWidget {
  final Widget childContent;
  final BuildContext parentContext;

  const AteneaBottomDialog({
    super.key,
    required this.childContent,
    required this.parentContext,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.90,
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(parentContext);
                },
                child: SvgPicture.asset(
                  'assets/svg/close.svg',
                  height: 30.0,
                  width: 30.0,
                  color: AppColors.grayColor,
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                width: double.infinity,
                child: childContent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}