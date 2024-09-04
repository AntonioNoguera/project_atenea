import 'package:flutter/material.dart';
import '../../core/utils/AppTheme.dart';

class AtenaDropDown extends StatefulWidget {
  final List<String> items;
  final String? initialValue;
  final Function(String) onChanged;
  final String hint;

  const AtenaDropDown({
    super.key,
    required this.items,
    this.initialValue,
    required this.onChanged,
    this.hint = 'Seleccione una opción',
  });

  @override
  // ignore: library_private_types_in_public_api
  _AtenaDropDownState createState() => _AtenaDropDownState();
}

class _AtenaDropDownState extends State<AtenaDropDown> with SingleTickerProviderStateMixin {
  bool isOpen = false;
  String? selectedItem;

  @override
  void initState() {
    super.initState();
    selectedItem = widget.initialValue;
  }

  void toggleDropdown() {
    setState(() {
      isOpen = !isOpen;
    });
  }

  void selectItem(String item) {
    widget.onChanged(item);
    setState(() {
      selectedItem = item;
      isOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 3.0) ,
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none, // Evita que el contenido se recorte
          children: [
            GestureDetector(
              onTap: toggleDropdown,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: (isOpen) ? 11.8 : 12),
                decoration: BoxDecoration(
                  border: Border.all(color: (isOpen) ? AppColors.secondaryColor : AppColors.primaryColor, width: (isOpen) ? 1.8 : 1.3 ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedItem ?? widget.hint,
                      style: AppTextStyles.builder(
                        color: AppColors.primaryColor,
                        size: FontSizes.body1,
                      ),
                    ),
                    Icon(
                      isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                      color: AppColors.primaryColor,
                    ),
                  ],
                ),
              ),
            ),

            AnimatedPositioned(
              duration: const Duration(milliseconds: 100),
              top: (isOpen || selectedItem != null) ? -10 : 10, // Ajuste en la posición top
              left: (isOpen || selectedItem != null) ? 9 : 15 ,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 100),
                opacity: (isOpen || selectedItem != null) ? 1 : 0,  
                child: Container(
                  color: AppColors.ateneaWhite,
                  padding: const EdgeInsets.symmetric(horizontal: 4.0), // Asegura el padding para evitar corte
                  child: Text(
                    widget.hint,
                    style: AppTextStyles.builder(
                      color: AppColors.primaryColor.withOpacity(1),
                      size: FontSizes.body2,
                      weight: FontWeight.w100
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: isOpen ? (widget.items.length * 25.0) : 0,
          child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: widget.items.map((item) {
              return GestureDetector(
                onTap: () => selectItem(item),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    border: const Border(
                      bottom: BorderSide(color: AppColors.placeholderInputColor),
                    ),
                    color: selectedItem == item
                        ? Colors.grey.shade200
                        : Colors.white,
                  ),
                  child: Text(
                    item,
                    style: AppTextStyles.builder(
                      color: AppColors.primaryColor,
                      size: FontSizes.body1,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    ),
    );
  }
}