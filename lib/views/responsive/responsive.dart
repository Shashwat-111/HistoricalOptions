import 'package:flutter/material.dart';
import 'package:fno_view/controllers/layout_controller.dart';
import 'package:get/get.dart';
import '../../utils/constants.dart';

class ResponsiveLayout extends StatefulWidget {

  final Widget mobileBody;
  final Widget desktopBody;

  const ResponsiveLayout({super.key, required this.mobileBody, required this.desktopBody});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  LayoutController layoutController = Get.put(LayoutController());
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints){
          if(constraints.maxWidth < mobileWidth){
            layoutController.changeLayout(Layout.mobile);
            return widget.mobileBody;
          } else {
            layoutController.changeLayout(Layout.desktop);
            return widget.desktopBody;
          }
    });
  }
}
