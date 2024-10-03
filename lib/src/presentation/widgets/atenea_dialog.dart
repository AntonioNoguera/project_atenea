import 'package:flutter/material.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button.dart';

class AteneaDialog extends StatelessWidget {
  final String title;
  final String content;

  const AteneaDialog({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title, 
        style: AppTextStyles.builder(
          color: AppColors.primaryColor,
          size: FontSizes.h4, 
        ),
        textAlign : TextAlign.center
      ),

      content: Text(
        content,
        style: AppTextStyles.builder(
          color: AppColors.ateneaBlack,
          size: FontSizes.body2, 
        ),
        textAlign : TextAlign.center
      ), 

      actions: <Widget>[
        Container(
          width: double.infinity, 
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child:AteneaButton(
                  text: "CLOSE",
                  onPressed: () {
                    Navigator.of(context).pop();
                  }, 
                  textStyle: AppTextStyles.builder(
                    color: AppColors.ateneaWhite,
                    size: FontSizes.body2, 
                  ),
                )
              ),
                
              const SizedBox(width: 8),

              Expanded(
                child:AteneaButton(
                  text: "CLOSE",
                  onPressed: () {
                    Navigator.of(context).pop();
                  },  
                  textStyle: AppTextStyles.builder(
                    color: AppColors.ateneaWhite,
                    size: FontSizes.body2, 
                  ),
                )
              ),
            ],
          ),
        ),
      ],
    );
  }
}