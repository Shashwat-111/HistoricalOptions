import 'package:flutter/material.dart';

showCustomPopup({required BuildContext context, required Widget child, required String title}){
  showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        alignment: Alignment.center,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
        title: Text(title),
        titlePadding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
        titleTextStyle: Theme.of(context).textTheme.titleLarge,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: child,
          )
        ],
      )
  );
}