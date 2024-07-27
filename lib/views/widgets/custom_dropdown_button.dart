import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropdownButton extends StatefulWidget {
  final String labelText;
  final String hintText;
  final double width;
  final double height;
  final List<String> initialMenuItems;
  final void Function(String?)? onChanged;

  const CustomDropdownButton({
    super.key,
    this.height = 30,
    required this.labelText,
    required this.hintText,
    required this.width,
    required this.initialMenuItems, this.onChanged,
  });

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  late List<String> menuItems;
  late void Function(String?)? newOnchange;

  @override
  void initState() {
    super.initState();
    menuItems = widget.initialMenuItems;
    newOnchange = widget.onChanged;
  }

  @override
  Widget build(BuildContext context) {
    String? selectedValue;
    return Center(
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: DropdownButtonFormField2<String>(
          decoration: InputDecoration(
            labelStyle: const TextStyle(fontSize: 12),
            labelText: widget.labelText,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            contentPadding: const EdgeInsets.symmetric(vertical: 2),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
          hint: Text(
            widget.hintText,
            style: const TextStyle(fontSize: 14),
          ),
          items: menuItems
              .map((item) => DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ))
              .toList(),
          onChanged: newOnchange,
          onSaved: (value) {
            selectedValue = value.toString();
          },
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.only(right: 8),
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(
              Icons.arrow_drop_down,
            ),
            iconSize: 24,
          ),
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            padding: EdgeInsets.symmetric(horizontal: 16),
          ),
        ),
      ),
    );
  }
}
