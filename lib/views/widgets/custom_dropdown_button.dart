import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropdownButton extends StatefulWidget {
  final String labelText;
  final String hintText;
  final double width;
  final List menuItems;
  const CustomDropdownButton({super.key, required this.labelText, required this.hintText, required this.width, required this.menuItems});

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Center(
      child:  SizedBox(
        width: widget.width,
        height: 30,
        child: DropdownButtonFormField2<String>(
          decoration: InputDecoration(
            labelStyle: TextStyle(fontSize: 12),
            labelText: widget.labelText,
            alignLabelWithHint: true,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            // Add Horizontal padding using menuItemStyleData.padding so it matches
            // the menu padding when button's width is not specified.
            contentPadding: EdgeInsets.symmetric(vertical: 0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
          hint: Text(
            widget.hintText,
            style: const TextStyle(fontSize: 14),
          ),
          items: widget.menuItems
              .map((item) => DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style:const TextStyle(
                fontSize: 14,
              ),
            ),
          ))
              .toList(),
          onChanged: (value) {
            //Do something when selected item is changed.
          },
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
