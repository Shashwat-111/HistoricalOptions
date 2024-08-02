import 'package:flutter/material.dart';

showCustomPopup({required BuildContext context, required Widget child, required String title}){
  showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        alignment: Alignment.center,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
        title: Text(title),
        titlePadding: EdgeInsets.fromLTRB(8, 8, 0, 0),
        titleTextStyle: const TextStyle(fontSize: 22,fontWeight: FontWeight.w500,color: Colors.black),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: child,
          )
        ],
      )
  );
}