import 'package:flutter/material.dart';

class MyTextIconButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function() onPressed;
  const MyTextIconButton({super.key, required this.icon, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
          iconColor: WidgetStateProperty.all(Colors.black),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(8),
            side: const BorderSide(color: Colors.white),
          )),
        ),
        onPressed: onPressed,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          //textBaseline: TextBaseline.alphabetic,
          children: [
            Icon(icon),
            const SizedBox(width: 5),
            Text(text, style: const TextStyle(color: Colors.black),),
          ],
        ));
  }
}
