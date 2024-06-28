import 'package:flutter/material.dart';

DropdownMenuItem<String> buildMenuItems(String item) => DropdownMenuItem(
  value: item,
  child: Text(
    item,
    style: const TextStyle(fontSize: 12),
  ),
);