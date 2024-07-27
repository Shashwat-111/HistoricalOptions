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
        IconButton(
          tooltip: "Lock Chart",
          onPressed: (){
            setState(() {
              panLock = !panLock;
            });
            },
          icon: panLock
            ? const Icon(Icons.lock_outline_sharp)
            : const Icon(Icons.lock_open_sharp,),),
        IconButton(onPressed: (){}, icon: const Icon(Icons.candlestick_chart_outlined),tooltip:"Candle type"),
        IconButton(onPressed: (){}, icon: const Icon(Icons.mode_edit_outlined), tooltip:"annotate",),
        IconButton(onPressed: (){}, icon: const Icon(Icons.straighten_outlined), tooltip:"measure",),
        IconButton(onPressed: (){}, icon: const Icon(Icons.title_outlined), tooltip:"Add Text",),
        IconButton(onPressed: (){}, icon: const Icon(Icons.chat_bubble_outline_sharp), tooltip:"tooltip",),

      ],
    );
  }
}
