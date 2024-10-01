import 'package:flutter/material.dart';

class AteneaBackground extends StatelessWidget {
  final Widget child;

  const AteneaBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              'assets/images/backgrounds/down_left_asset.png',
              width: 180,
              height: 450,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
              top: 10,
              right: 10,
              child: Image.asset(
                'assets/images/backgrounds/living_fime.png',
                width: 150,
                height: 30,
                fit: BoxFit.cover,
              )),
          Container(
            color: Colors.transparent,
            child: child,
          ),
        ],
      ),
    );
  }
}
