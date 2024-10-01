import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AteneaDialog extends StatelessWidget {
  final Widget childContent;
  final BuildContext parentContext;

  const AteneaDialog({
    super.key,
    required this.childContent,
    required this.parentContext,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(0),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(parentContext);
                  },
                  child: SvgPicture.asset(
                    'assets/svg/Close.svg',
                    height: 30.0,
                    width: 30.0,
                    // color: AppColors.grayColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            childContent,
          ],
        ),
      ),
    );
  }
}
