import 'package:flutter/cupertino.dart';
import 'package:popover/popover.dart';

customPopup({required BuildContext context, required Widget child, PopoverDirection direction = PopoverDirection.right}){
  showPopover(
      context: context,
      bodyBuilder:(context) => child,
      transitionDuration: const Duration(milliseconds: 100),
      direction: direction,
      radius: 0,
      arrowHeight: 8.25,
      arrowWidth: 16.5
  );
}