import "package:flutter/material.dart";

class MyAppBar extends StatefulWidget {
  const MyAppBar({super.key});

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  List<String> expiries = [
    "09 May 2024",
    "15 May 2024",
    "23 May 2024",
    "31 May 2024",
    "07 June 2024",
    "14 June 2024",
    "21 June 2024",
  ];
  String? currentExpiry;
  List<String> indicators = [
    "Atrr",
    "BollingerBand",
    "EMA",
    "Macd",
    "Momentum",
    "RSI",
    "SMA",
    "Stochastic",
    "Technical",
    "TMA"
  ];
  String? currentIndicator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          children: <Widget>[
            const CircleAvatar(
              maxRadius: 15,
              backgroundColor: Colors.black,
              child: Text(
                "S",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            const Text("BANKNIFTY"),
            const SizedBox(
              width: 10,
            ),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2)),
                child: const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.candlestick_chart),
                      Text("1m  3m  5m ")
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            DropdownButton(
                focusColor: Colors.white,
                hint: const Text("Select Expiry"),
                value: currentExpiry,
                items: expiries.map(buildMenuItems).toList(),
                onChanged: (item) {
                  setState(() {
                    currentExpiry = item;
                  });
                }),
            const SizedBox(
              width: 20,
            ),
            DropdownButton(
                focusColor: Colors.white,
                hint: const Text("Select Indicator"),
                value: currentIndicator,
                items: indicators.map(buildMenuItems).toList(),
                onChanged: (item) {
                  setState(() {
                    currentIndicator = item;
                  });
                }),
          ],
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItems(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(fontSize: 12),
        ),
      );
}
