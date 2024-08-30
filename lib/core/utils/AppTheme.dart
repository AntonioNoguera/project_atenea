import 'package:flutter/material.dart';

class AppColors {
  //Primary and Secondary Colors
  static const Color primaryColor = Color.fromRGBO(14, 113, 54, 1);
  static const Color secondaryColor = Color.fromRGBO(101, 190,69,1);

  //Input Related Colorss
  static const Color grayColor = Color.fromRGBO(114, 114, 114, 1);
  static const Color placeholderInputColor = Color.fromRGBO(101, 190, 69, 0.6);
  
  //Generic Purpose Colors
  static const Color ateneaWhite = Colors.white;
  static const Color ateneaBlack = Colors.black;
  static const Color ateneaRed = Color.fromRGBO(244, 104, 104, 1);
  static const Color textColor = Color.fromRGBO(65, 65, 65, 1);

  //Event Tag Colors
  static const Color eventInstitutional = Color.fromRGBO(225, 162, 0,1);
}

class FontSizes{
  static const double h1 = 50.0;
  static const double h2 = 45.0;
  static const double h3 = 30.0;
  static const double h4 = 25.0;

  static const double body1 = 19.0;
  static const double body2 = 0.0;
  static const double body3 = 0.0;
  static const double body4 = 12.0;

  static const double captions = 10.0;
}

class AppTextStyles {
  
  static const TextStyle headline1 = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static const TextStyle bodyText1 = TextStyle(
    fontSize: 16.0,
    color: AppColors.textColor,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}

class AppSizes {
  static const double smallPadding = 8.0;
  static const double mediumPadding = 16.0;
  static const double largePadding = 32.0;
  static const double borderRadius = 12.0;
}
