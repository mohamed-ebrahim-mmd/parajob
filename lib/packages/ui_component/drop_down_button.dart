import 'package:flutter/material.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class DropDownButton extends StatefulWidget {
  final List<String> options;
  final String label;
  final String? initialSelection;
  final void Function(String)? onSelected;

  const DropDownButton({
    super.key,
    required this.options,
    required this.label,
    this.initialSelection,
    this.onSelected,
  });

  @override
  State<DropDownButton> createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialSelection;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      width: context.wPct(90),
      menuHeight: context.hPct(22),
      initialSelection: _selectedValue,
      hintText: widget.label,
      textStyle: TextStyle(
        color: AppColors.softWhite70,
        fontSize: context.wPct(4.8),
        fontWeight: FontWeight.w500,
      ),
      trailingIcon: const Icon(Icons.arrow_drop_down),

      dropdownMenuEntries: widget.options.map((option) {
        final bool isSelected = _selectedValue == option;

        return DropdownMenuEntry(
          value: option,
          label: option,
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              isSelected
                  ? AppColors.aquaTeal.withOpacity(0.9)
                  : Colors.transparent,
            ),
            shape: const WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
            padding: const WidgetStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
          ),
        );
      }).toList(),

      alignmentOffset: const Offset(0, 10),

      onSelected: (value) {
        setState(() {
          _selectedValue = value;
        });
        widget.onSelected?.call(value!);
      },
    );
  }
}
