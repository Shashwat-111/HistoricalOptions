import "package:flutter/material.dart";
import "package:fno_view/controllers/option_controller.dart";
import "package:get/get.dart";

import "../../utils/convert_timeframe_to_minutes.dart";
import "../../utils/dropdown_menu_item.dart";

class MyAppBar extends StatefulWidget {
  const MyAppBar({super.key});

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  OptionDataController odController = Get.put(OptionDataController());
  String? currentExpiry;
  String? currentStrike;
  String? currentIndicator;

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

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    print("height appbar : ${MediaQuery.of(context).size.height}");
    print("width appbar : ${MediaQuery.of(context).size.width}");
    return Obx(() {
      if (width > 1000) {
        return buildFullSizeAppBar();
      } else {
        return buildShorterAppBar();
      }
    });
  }

  Widget buildFullSizeAppBar() {
    return SizedBox(
      height: 50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          buildCircleAvatar(),
          buildSearchIcon(),
          buildStockName(),
          const SizedBox(width: 20),
          buildCandleTimeSelector(),
          const SizedBox(width: 20),
          buildExpirySelectionDropdown(),
          const SizedBox(width: 20),
          buildCallPutSegmentedButton(),
          const SizedBox(width: 20),
          buildStrikePriceSelectDropdownButton(),
          const SizedBox(width: 20),
          buildRefreshButton(),
          const Spacer(),
          // const Text("Dark Mode"),
          darkModeIconButton(),
          const SizedBox(width: 10),
        ],
      ),
    );
  }

  Widget buildShorterAppBar() {
    return SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildCircleAvatar(),
            TextButton(onPressed: () {
              showDialog(context: context, builder: (context) {
                return StatefulBuilder(builder: (context,setState){
                 return Dialog(
                    child: Container(
                      height: double.infinity-80,
                      width: double.infinity-40,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          buildCandleTimeSelector(),
                          buildExpirySelectionDropdown(),
                          buildCallPutSegmentedButton(),
                          buildStrikePriceSelectDropdownButton(),
                          buildRefreshButton(),
                        ],
                      ),
                    ),
                  );
                });
              });
            }, child: const Text("New Chart")),
            IconButton(
                onPressed: () {},
                icon: const Row(
                  children: [Icon(Icons.analytics_sharp), Text("Indiactor")],
                )),
            const Spacer(),
            buildDarkModeSwitch()
          ],
        ));
  }

  Switch buildDarkModeSwitch() {
    return Switch(
        value: odController.isDarkMode.value,
        onChanged: (bool newValue) {
          setState(() {
            odController.switchDarkMode(newValue);
          });
        });
  }

  Widget darkModeIconButton() {
    return Tooltip(
      message: 'Switch theme',
      child: IconButton(
          onPressed: (){
            setState(() {
              odController.switchDarkMode(!odController.isDarkMode.value);
            });
          },
          icon: odController.isDarkMode.value ? const Icon(Icons.dark_mode) : const Icon(Icons.light_mode)
      ),
    );
  }

  TextButton buildRefreshButton() {
    return TextButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(0), // This makes the shape rectangular
            side: const BorderSide(color: Colors.white),
          )),
        ),
        onPressed: () {
          if (currentExpiry != null && currentStrike != null) {
            odController.getData(
                expiry: currentExpiry!,
                right: odController.selectedRight.first,
                strike: currentStrike!);
          }
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.refresh),
            const SizedBox(
              width: 5,
            ),
            Text("Refresh${odController.temp}"),
          ],
        ));
  }

  DropdownButton<String> buildStrikePriceSelectDropdownButton() {
    return DropdownButton(
        focusColor: Colors.transparent,
        hint: const Text("Strike Price"),
        value: currentStrike,
        items: odController.strikePriceList.map(buildMenuItems).toList(),
        onChanged: (item) {
          setState(() {
            currentStrike = item;
            if (currentStrike != null) {
              odController.setStrikeprice(item!);
            }
          });
        });
  }

  SegmentedButton<String> buildCallPutSegmentedButton() {
    return SegmentedButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(0), // This makes the shape rectangular
            side: const BorderSide(), // Optional: Add a border color
          )),
        ),
        showSelectedIcon: false,
        segments: const [
          ButtonSegment(value: "call", label: Text("call")),
          ButtonSegment(value: "put", label: Text("put")),
        ],
        selected: odController.selectedRight,
        onSelectionChanged: (value) {
          odController.updateRight(value);
          if (currentExpiry != null) {
            odController.getStrikePriceData(
                expiry: currentExpiry!,
                right: odController.selectedRight.first);
            setState(() {
              currentStrike = null;
            });
          }
        });
  }

  DropdownButton<String> buildExpirySelectionDropdown() {
    return DropdownButton(
        focusColor: Colors.transparent,
        hint: const Text("Select Expiry"),
        value: currentExpiry,
        items: odController.expiryDates.map(buildMenuItems).toList(),
        onChanged: (item) {
          //print(odController.expiryDates.map(buildMenuItems).toList());
          setState(() {
            currentExpiry = item;
            if (currentExpiry != null) {
              //print(odController.selectedRight.first);
              odController.getStrikePriceData(
                  expiry: currentExpiry!,
                  right: odController.selectedRight.first);
              currentStrike = null;
            }
          });
        });
  }

  SegmentedButton<String> buildCandleTimeSelector() {
    return SegmentedButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(0), // This makes the shape rectangular
            side: const BorderSide(), // Optional: Add a border color
          )),
        ),
        showSelectedIcon: false,
        segments: const [
          ButtonSegment(value: "1m", label: Text("1m")),
          ButtonSegment(value: "5m", label: Text("5m")),
          ButtonSegment(value: "15m", label: Text("15m"))
        ],
        selected: odController.selectedCandleTimeFrame,
        onSelectionChanged: (value) {
          setState(() {
            odController.updateCandleTimeFrame(value);
            int timeFrame = convertTimeFrameToMinutes(
                odController.selectedCandleTimeFrame.first);
            odController.aggregateOHLC(
                odController.ohlcDataListOriginal, timeFrame);
          });
        });
  }

  Text buildStockName() => const Text("BANKNIFTY");

  IconButton buildSearchIcon() =>
      IconButton(onPressed: () {}, icon: const Icon(Icons.search));

  CircleAvatar buildCircleAvatar() {
    return const CircleAvatar(
        backgroundColor: Colors.transparent,
        maxRadius: 15,
        child: Icon(Icons.person));
  }
}
