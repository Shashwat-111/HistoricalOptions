import 'package:flutter/material.dart';

void showCustomSnackBar({required BuildContext context, required String text}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      margin: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.8,
        bottom: MediaQuery.of(context).size.height * 0.9,
        right: 10,
      ),
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.horizontal,
      content: Text(text)));
}
