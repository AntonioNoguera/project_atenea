import 'package:flutter/material.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button_v2.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart';

class AteneaCheckboxButton extends StatefulWidget {
  final bool initialState;
  final ValueChanged<bool> onChanged;
  final String checkboxText; 

  static Map<bool, AteneaButtonStyles> checkStates = {
      true : const AteneaButtonStyles(
        backgroundColor: AppColors.heavyPrimaryColor, 
        textColor: AppColors.ateneaWhite,
        hasBorder: false
      ),

      false: const AteneaButtonStyles(
        backgroundColor: AppColors.ateneaWhite, 
        textColor: AppColors.primaryColor,
        hasBorder: true
      ),
  };

  static Map<bool, SvgButtonStyle?> svgStates = {
      true : SvgButtonStyle(
        svgPath: 'assets/svg/check.svg',  
        svgDimentions: 15.0
      ),

      false: null,
  };

  static Map<bool, TextStyle> checkStatesText = {
      true : AppTextStyles.builder(
        color: AppColors.ateneaWhite,
        size: FontSizes.body2,
        weight: FontWeights.regular,   
      ),

      false: AppTextStyles.builder(
        color: AppColors.primaryColor.withOpacity(0.4),
        size: FontSizes.body2,
        weight: FontWeights.regular,   
      ),
  };

  const AteneaCheckboxButton ({
    super.key, 
    required this.initialState, 
    required this.onChanged, 
    required this.checkboxText});

  @override
  _ToggleButtonState createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<AteneaCheckboxButton> {
  late bool _isSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.initialState;
  }

  void _toggleSelection() {
    setState(() {
      _isSelected = !_isSelected;
    });
    widget.onChanged(_isSelected);
  }

  @override
  Widget build(BuildContext context) {
    
    return AteneaButtonV2(
      onPressed: _toggleSelection, 
      btnStyles:  AteneaCheckboxButton.checkStates[_isSelected]!,
      textStyle: AteneaCheckboxButton.checkStatesText[_isSelected]!,
      svgIcon: AteneaCheckboxButton.svgStates[_isSelected],
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      text : widget.checkboxText, 
    );
  }
}
