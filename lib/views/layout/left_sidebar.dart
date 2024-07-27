import 'package:flutter/material.dart';

class LeftSidebar extends StatefulWidget {
  const LeftSidebar({super.key});

  @override
  State<LeftSidebar> createState() => _LeftSidebarState();
}

class _LeftSidebarState extends State<LeftSidebar> {
  bool panLock = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(onPressed: (){setState(() {
          panLock = !panLock;
        });}, icon: panLock ? Icon(Icons.lock_outline_sharp) : Icon(Icons.lock_open_sharp)),
        IconButton(onPressed: (){}, icon: Icon(Icons.candlestick_chart_outlined)),
        IconButton(onPressed: (){}, icon: Icon(Icons.mode_edit_outlined)),
        IconButton(onPressed: (){}, icon: Icon(Icons.straighten_outlined)),
        IconButton(onPressed: (){}, icon: Icon(Icons.text_fields_sharp)),

      ],
    );
  }
}
