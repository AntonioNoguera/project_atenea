import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MemberRow extends StatelessWidget {
  final String contentType;

  const MemberRow({
    super.key,
    required this.contentType,  // Especificamos que este valor es requerido.
  });

  @override
  Widget build(BuildContext context) {
    return  Row(
        children: [
          Expanded(
            child: Text(
              contentType,
              style: TextStyle(color: Colors.white),
            ),
          ),
          SvgPicture.asset(
            'assets/svg/Account.svg',
            height: 27.0,
            width: 27.0,
          ),
        ], 
    );
  }
}
