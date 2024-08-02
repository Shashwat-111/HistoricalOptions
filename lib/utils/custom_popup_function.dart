import 'package:flutter/material.dart';

customPopup({required BuildContext context, required Widget child, required String title}){
  showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        alignment: Alignment.center,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
        title: Text(title),
        titleTextStyle: const TextStyle(fontSize: 22,fontWeight: FontWeight.w500,color: Colors.black),
        children: [
          child
        ],
      )
  );
}