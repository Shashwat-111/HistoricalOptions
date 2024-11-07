import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/layout_controller.dart';

void showCustomSnackBar({required BuildContext context, required String text}) {
  LayoutController layoutController = Get.put(LayoutController());

  //snackbar for mobile
  if (layoutController.currentLayout.value == Layout.mobile) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.vertical,
        content: Text(text)));
  }

  //snackbar for desktop
  if (layoutController.currentLayout.value == Layout.desktop) {
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
}
