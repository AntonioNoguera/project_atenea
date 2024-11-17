import 'package:flutter/material.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';

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
  State<AtenaDropDown> createState() => _AtenaDropDownState();
}

class _AtenaDropDownState extends State<AtenaDropDown> {
  bool isOpen = false;
  String? selectedItem;
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    selectedItem = widget.initialValue;
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void toggleDropdown() {
    if (isOpen) {
      _removeOverlay();
    } else {
      _showOverlay();
    }
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
    _removeOverlay();
  }

  void _showOverlay() {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: position.dy + renderBox.size.height + 8, // Desplazamiento debajo del campo
        left: position.dx,
        width: renderBox.size.width,
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.placeholderInputColor),
            ),
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: widget.items.map((item) {
                return GestureDetector(
                  onTap: () => selectItem(item),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    decoration: BoxDecoration(
                      border: const Border(
                        bottom: BorderSide(color: AppColors.placeholderInputColor),
                      ),
                      color: selectedItem == item ? Colors.grey.shade200 : Colors.white,
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
        ),
      ),
    );

    overlay.insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleDropdown,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.ateneaWhite,
          border: Border.all(
            color: isOpen ? AppColors.secondaryColor : AppColors.primaryColor,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(10),
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
    );
  }
}
