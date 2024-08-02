import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../../utils/custom_popup_function.dart';

class ProfileIcon extends StatelessWidget {
  const ProfileIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        showCustomPopup(
            context: context,
            title: "Profile",
            child: Container(height: 300,width: 300,));
      },
      child: SizedBox(
        width: sideBarWidth,
        child: Center(
          child: CircleAvatar(
            radius: ((appBarHeight / 2) - 5),
            backgroundColor: Colors.green[400],
            child: const Text(
              "S",
              style: TextStyle(
                  fontSize: (appBarHeight / 2),
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}