import 'package:flutter/material.dart';

class TimeFrameSelectorButton extends StatefulWidget {
  const TimeFrameSelectorButton({super.key});

  @override
  State<TimeFrameSelectorButton> createState() => _TimeFrameSelectorButtonState();
}

class _TimeFrameSelectorButtonState extends State<TimeFrameSelectorButton> {
  String selectedValue = "1m";
  Map<String, VoidCallback> timeFrameWithFunction = {
    "1m" : (){
      //todo add logic to change the candle timeframe
    },
    "5m" : (){

    },
    "15m" : (){

    },
  };
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: timeFrameWithFunction.keys.length*40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: timeFrameWithFunction.keys.map((time) => GestureDetector(
            onTap: (){
              timeFrameWithFunction[time]!();
              setState(() {
                selectedValue = time;
              });
            },
            child: Container(
              height: 30,
              width: 40,
              decoration: BoxDecoration(shape: BoxShape.rectangle, borderRadius: const BorderRadius.all(Radius.circular(8)),color: selectedValue == time ? Colors.grey[200] : Colors.white),
              child: Center(child: Text(time, style: TextStyle(fontWeight: selectedValue == time ? FontWeight.bold : null))),
            ))).toList()
        ),
      ),
    );
  }
}
