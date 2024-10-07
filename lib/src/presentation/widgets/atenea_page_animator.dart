import 'package:flutter/material.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_background.dart';

class AteneaPageAnimator extends PageRouteBuilder {
  final Widget page;

  AteneaPageAnimator ({required this.page}) : super(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}
