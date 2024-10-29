import 'package:flutter/material.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart';

class AteneaCheckboxButton extends StatefulWidget {
  final bool initialState;
  final ValueChanged<bool> onChanged;
  final String checkboxText; 

  static Map<bool, AteneaButtonStyles> checkStates = {
      true : AteneaButtonStyles(
        backgroundColor: AppColors.primaryColor, 
        textColor: AppColors.ateneaWhite,
        hasBorder: false
      ),

      false: AteneaButtonStyles(
        backgroundColor: AppColors.ateneaWhite, 
        textColor: AppColors.primaryColor,
        hasBorder: true
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
    
    return AteneaButton(
      onPressed: _toggleSelection,
      backgroundColor:   _isSelected ? Colors.blue : Colors.grey, 
      text : widget.checkboxText,
    );
  }
}
