import 'package:flutter/material.dart';

class AteneaCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? margin;

  const AteneaCard({
    super.key,
    required this.child,
    this.margin, 
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: SizedBox(
        width: double.infinity,
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
