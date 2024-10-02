import 'package:flutter/material.dart';

class AppColors {
  //Primary and Secondary Colors
  static const Color primaryColor = Color.fromRGBO(14, 113, 54, 1);
  static const Color secondaryColor = Color.fromRGBO(101, 190,69,1);
  static const Color heavyPrimaryColor = Color.fromRGBO(5, 66, 29, 1); 
  static const Color lightPrimaryColor = Color.fromRGBO(14, 113, 54, .6);

  //Input Related Colorss
  static const Color grayColor = Color.fromRGBO(114, 114, 114, 1);
  static const Color placeholderInputColor = Color.fromRGBO(101, 190, 69, 0.6);
  
  //Generic Purpose Colors
  static const Color ateneaWhite = Color.fromRGBO(254,247,255,1);
  static const Color ateneaBlack = Colors.black;
  static const Color ateneaRed = Color.fromRGBO(255, 87, 51, .60);
  static const Color textColor = Color.fromRGBO(65, 65, 65, 1);

  //Event Tag Colors
  static const Color eventInstitutional = Color.fromRGBO(225, 162, 0,1);
  static const Color eventAcademic = Color.fromRGBO(113, 14, 85, 1);
  static const Color eventResearch = Color.fromRGBO(39, 118, 12, 1);
  static const Color eventSports = Color.fromRGBO(202, 30, 30, 1);
  static const Color eventArtistic = Color.fromRGBO(16, 22, 177, 1);
  static const Color eventInnovation = Color.fromRGBO(102, 102, 102, 1);
  static const Color eventCultural = Color.fromRGBO(121, 40, 14, 1);
  static const Color eventLanguagues = Color.fromRGBO(12, 126, 99, 1);
  static const Color eventSocial = Color.fromRGBO(37, 37, 37, 1);
  static const Color eventExchange = Color.fromRGBO(0, 89, 46, 1);
}

class FontSizes {
  //Headers
  static const double h1 = 50.0;
  static const double h2 = 45.0;
  static const double h3 = 35.0;
  static const double h4 = 25.0;

  //Body
  static const double body1 = 19.0;
  static const double body2 = 15.0;
  static const double body3 = 12.0; 

  //Captions (Pref avoid use to small for usabillity)
  static const double captions = 10.0;
}

class FontWeights {
  static const FontWeight light = FontWeight.w200;
  static const FontWeight regular = FontWeight.w300;
  static const FontWeight semibold = FontWeight.w500;
  static const FontWeight bold = FontWeight.w800;
}

class AppTextStyles {
  //For only really common styles related to the font

  static TextStyle builder(
      { Color color = AppColors.primaryColor,
        double size = FontSizes.h1,
        FontWeight weight = FontWeights.regular }) {

    return TextStyle(
      fontFamily: 'RadioCanada',
      fontSize: size,
      fontWeight: weight,
      color:color, // Aquí se usa el parámetro color
    );
  }
}
