import "package:flutter/material.dart";
import "package:fno_view/controllers/option_controller.dart";
import "package:get/get.dart";

class MyAppBar extends StatefulWidget {
  const MyAppBar({super.key});

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  
  OptionDataController odController = Get.put(OptionDataController());
  String? currentExpiry;
  String? currentStrike;
  // List<String> indicators = [
  //   "Atrr",
  //   "BollingerBand",
  //   "EMA",
  //   "Macd",
  //   "Momentum",
  //   "RSI",
  //   "SMA",
  //   "Stochastic",
  //   "Technical",
  //   "TMA"
  // ];
  //String? currentIndicator;

  @override
  Widget build(BuildContext context) {
    return
      Container(
        height: 50,
        width: double.infinity,
        //color: Color.fromRGBO(19,23,34,1),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                width: 20,
              ),
              Obx(
                () => SegmentedButton(
                    showSelectedIcon: false,
                    segments: const [
                      ButtonSegment(value: "1m", label: Text("1m")),
                      ButtonSegment(value: "5m", label: Text("5m")),
                      ButtonSegment(value: "15m", label: Text("15m"))
                    ],
                    selected: odController.selectedCandleTimeFrame,
                    onSelectionChanged: (value) {
                      odController.updateCandleTimeFrame(value);
                    }),
              ),
              const SizedBox(
                width: 20,
              ),
              Obx(
                () => DropdownButton(
                    focusColor: Colors.transparent,
                    hint: const Text("Select Expiry"),
                    value: currentExpiry,
                    items: odController.expiryDates.map(buildMenuItems).toList(),
                    onChanged: (item) {
                      setState(() {
                        currentExpiry = item;
                        if (currentExpiry != null){
                          print(odController.selectedRight.first);
                          odController.getStrikePriceData(expiry: currentExpiry!, right: odController.selectedRight.first);
                          currentStrike = null;
                        }


                      });
                    }),
              ),
              const SizedBox(
                width: 20,
              ),
              Obx(
                ()=> SegmentedButton(
                    showSelectedIcon: false,
                    segments: const [
                      ButtonSegment(value: "call", label: Text("call")),
                      ButtonSegment(value: "put", label: Text("put")),
                    ],
                    selected: odController.selectedRight,
                    onSelectionChanged: (value) {
                      odController.updateRight(value);
                      if (currentExpiry != null) {
                        odController.getStrikePriceData(expiry: currentExpiry!, right: odController.selectedRight.first);
                        setState(() {
                          currentStrike = null;
                        });

                      }
                    }
                    ),
              ),
              const SizedBox(
                width: 20,
              ),
              Obx(
                () => DropdownButton(
                    focusColor: Colors.transparent,
                    hint: const Text("Strike Price"),
                    value: currentStrike,
                    items:
                        odController.strikePriceList.map(buildMenuItems).toList(),
                    onChanged: (item) {
                      setState(() {
                        currentStrike = item;
                        if(currentStrike != null) {
                          odController.setStrikeprice(item!);
                        }
                      });
                    }),
              ),
              const SizedBox(
                width: 20,
              ),
              Obx(
                () => TextButton(
                    onPressed: () {
                      if(currentExpiry != null && currentStrike != null)
                      {
                      odController.getData(expiry: currentExpiry!, right: odController.selectedRight.first, strike: currentStrike!);
                      }
                    },
                    child: Text("Update${odController.temp}")),
              ),
              // Indicator Dropdown currently commented
              // DropdownButton(
              //     focusColor: Colors.white,
              //     hint: const Text("Select Indicator"),
              //     value: currentIndicator,
              //     items: indicators.map(buildMenuItems).toList(),
              //     onChanged: (item) {
              //       setState(() {
              //         currentIndicator = item;
              //       });
              //     }),
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
