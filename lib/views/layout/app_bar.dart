import "package:flutter/material.dart";
import "package:fno_view/controllers/option_controller.dart";
import "package:fno_view/utils/constants.dart";
import "package:get/get.dart";
import "../widgets/Indicator_dialog_box.dart";
import "../widgets/custom_dropdown_button.dart";
import "../widgets/my_text_icon_button.dart";
import "main_graph.dart";

class MyAppBar extends StatefulWidget {
  const MyAppBar({super.key});

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  OptionDataController odController = Get.put(OptionDataController());
  @override
  Widget build(BuildContext context) {
    return Row(
          children: [
            profilePictureMenuButton(),
            searchButton(),
            verticalDivider(),
            const SizedBox(width: 10),
            expiryDropdown(),
            const SizedBox(width: 10),
            rightDropdown(),
            const SizedBox(width: 10),
            strikeDropdown(),
            const SizedBox(width: 10),
            refreshButton(),
            const SizedBox(width: 10),
            verticalDivider(),
            const SizedBox(width: 10),
            indicatorsButton(),
            const Spacer(),
            notificationButton()
          ],
        );
  }

  Widget notificationButton() => const SizedBox(width: sideBarWidth,child: Icon(Icons.notifications_none_sharp),);

  Widget indicatorsButton()
  => MyTextIconButton(
      icon: Icons.bar_chart_sharp, text: "Indicators",
      onPressed: (){
        showDialog(context: context, builder: (context){
          return IndicatorDialogBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: const EdgeInsets.all(12),
                  child: const Text("Indicators", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                ),
                const SizedBox(height: 20,),
                IndicatorSelectorArea(indicators: supportedIndicatorList,),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                        onPressed: (){Navigator.pop(context);},
                        child: const Text("ok")
                    ),
                  ),
                )
              ],
            ),
          );
        });
      }
  );

  Widget refreshButton() => IconButton(onPressed: (){}, icon: const Icon(Icons.refresh));

  Widget expiryDropdown() {
    return Obx((){
      debugPrint("diff ${odController.expiryDates}");
      return CustomDropdownButton(
        initialMenuItems: odController.expiryDates,
        labelText: "Select Expiry",
        hintText: "Select Expiry",
        width: 150,
        onChanged: (v){
          ///todo: call the strike price api using this expiry "v".
          ///or wait for thr user to select a right (call/put)
        },
      );
    });
  }

  Widget rightDropdown() {
    return Obx((){
      debugPrint("diff ${odController.selectedRight}");
      return CustomDropdownButton(
        initialMenuItems: const ["CAll", "PUT"],
        labelText: "Select Right",
        hintText: "Select Right",
        width: 150,
        onChanged: (v){
          ///todo: call the strike price api using this expiry "v".
          ///or wait for thr user to select a right (call/put)
        },
      );
    });
  }

  Widget strikeDropdown() {
    return Obx((){
      debugPrint("diff ${odController.strikePriceList}");
      return CustomDropdownButton(
        initialMenuItems: odController.strikePriceList,
        labelText: "Select Strike",
        hintText: "Select Strike",
        width: 150,
        onChanged: (v){
          ///todo: call the strike price api using this expiry "v".
          ///or wait for thr user to select a right (call/put)
        },
      );
    });
  }
  Widget verticalDivider() {
    return const VerticalDivider(
        thickness: 2,
        color: Colors.black12,
        width: 10,
        indent: 5,
        endIndent: 5,
      );
  }

  Widget searchButton() {
    return MyTextIconButton(
      icon: Icons.search_rounded,
      text: "Bank Nifty",
      onPressed: () {
        //todo display this snackbar on right top like in web
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
            behavior: SnackBarBehavior.floating,
            dismissDirection: DismissDirection.horizontal,
            content: Text("Only BankNifty Data Currently Available")));
      },
    );
  }

  Widget profilePictureMenuButton() {
    return SizedBox(
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
    );
  }
}


//old App Bar
// class MyAppBar extends StatefulWidget {
//   const MyAppBar({super.key});
//
//   @override
//   State<MyAppBar> createState() => _MyAppBarState();
// }
//
// class _MyAppBarState extends State<MyAppBar> {
//   OptionDataController odController = Get.put(OptionDataController());
//   String? currentExpiry;
//   String? currentStrike;
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     return Obx(() => buildFullSizeAppBar());
//   }
//
//   Widget buildFullSizeAppBar() {
//     return Container(
//       //color: Colors.blue,
//       height: 52,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           //buildCircleAvatar(),
//           const SizedBox(width: 10),
//           searchStock(),
//           const SizedBox(width: 20),
//           Divider(),
//           timeFrameNew(),
//           //buildCandleTimeSelector(),
//           const SizedBox(width: 20),
//           VerticalDivider(
//             thickness: 2,
//             color: Colors.green,
//             width: 10,
//             indent: 2,
//             endIndent: 2,
//           ),
//           buildExpirySelectionDropdown(),
//           const SizedBox(width: 20),
//           //buildCallPutSegmentedButton(),
//           const SizedBox(width: 20),
//           buildStrikePriceSelectDropdownButton(),
//           //testDropDown(),
//           const SizedBox(width: 20),
//           buildRefreshButton(),
//           const SizedBox(width: 20),
//           TextButton(
//               style: ButtonStyle(
//                 shape: WidgetStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(
//                       8), // This makes the shape rectangular
//                   side: const BorderSide(color: Colors.white),
//                 )),
//               ),
//               onPressed: () {},
//               child: Row(
//                 children: [
//                   Icon(Icons.auto_graph_sharp),
//                   SizedBox(
//                     width: 5,
//                   ),
//                   Text("Indicators")
//                 ],
//               )),
//           // dropDownMenu(),
//           const Spacer(),
//           // const Text("Dark Mode"),
//           darkModeIconButton(),
//           const Tooltip(
//               message: "Notification",
//               child: Icon(Icons.notifications_none_sharp)),
//           const SizedBox(width: 10),
//         ],
//       ),
//     );
//   }
//
//   Widget buildDarkModeSwitch() {
//     return Switch(
//         value: odController.isDarkMode.value,
//         onChanged: (bool newValue) {
//           setState(() {
//             odController.switchDarkMode(newValue);
//           });
//         });
//   }
//
//   Widget darkModeIconButton() {
//     return Tooltip(
//       message: 'Switch theme',
//       child: IconButton(
//           onPressed: () {
//             setState(() {
//               odController.switchDarkMode(!odController.isDarkMode.value);
//             });
//           },
//           icon: odController.isDarkMode.value
//               ? const Icon(Icons.dark_mode_outlined)
//               : const Icon(Icons.light_mode)),
//     );
//   }
//
//   TextButton buildRefreshButton() {
//     return TextButton(
//         style: ButtonStyle(
//           shape: WidgetStateProperty.all<RoundedRectangleBorder>(
//               RoundedRectangleBorder(
//             borderRadius:
//                 BorderRadius.circular(8), // This makes the shape rectangular
//             side: const BorderSide(color: Colors.white),
//           )),
//         ),
//         onPressed: () {
//           if (currentExpiry != null && currentStrike != null) {
//             odController.getData(
//                 expiry: currentExpiry!,
//                 right: odController.selectedRight.first,
//                 strike: currentStrike!);
//           }
//         },
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Icon(Icons.refresh),
//             const SizedBox(
//               width: 5,
//             ),
//             Text("Refresh${odController.temp}"),
//           ],
//         ));
//   }
//
//   DropdownButton<String> buildStrikePriceSelectDropdownButton() {
//     return DropdownButton(
//         focusColor: Colors.transparent,
//         hint: const Text("Strike Price"),
//         value: currentStrike,
//         items: odController.strikePriceList.map(buildMenuItems).toList(),
//         onChanged: (item) {
//           setState(() {
//             currentStrike = item;
//             if (currentStrike != null) {
//               odController.setStrikeprice(item!);
//             }
//           });
//         });
//   }
//
// // //todo
// //   Widget dropDownMenu(){
// //     return const DropdownMenu(
// //         onSelected: ,
// //         dropdownMenuEntries: [
// //           DropdownMenuEntry(value: "28000", label: "123000"),
// //           DropdownMenuEntry(value: "28001", label: "123001"),
// //           DropdownMenuEntry(value: "28002", label: "123002"),
// //     ]);
// //   }
//   SegmentedButton<String> buildCallPutSegmentedButton() {
//     return SegmentedButton(
//         style: ButtonStyle(
//           shape: WidgetStateProperty.all<RoundedRectangleBorder>(
//               RoundedRectangleBorder(
//             borderRadius:
//                 BorderRadius.circular(0), // This makes the shape rectangular
//             side: const BorderSide(), // Optional: Add a border color
//           )),
//         ),
//         showSelectedIcon: false,
//         segments: const [
//           ButtonSegment(value: "call", label: Text("call")),
//           ButtonSegment(value: "put", label: Text("put")),
//         ],
//         selected: odController.selectedRight,
//         onSelectionChanged: (value) {
//           odController.updateRight(value);
//           if (currentExpiry != null) {
//             odController.getStrikePriceData(
//                 expiry: currentExpiry!,
//                 right: odController.selectedRight.first);
//             setState(() {
//               currentStrike = null;
//             });
//           }
//         });
//   }
//
//   DropdownButton<String> buildExpirySelectionDropdown() {
//     return DropdownButton(
//         focusColor: Colors.transparent,
//         hint: const Text("Select Expiry"),
//         value: currentExpiry,
//         items: odController.expiryDates.map(buildMenuItems).toList(),
//         onChanged: (item) {
//           //print(odController.expiryDates.map(buildMenuItems).toList());
//           setState(() {
//             currentExpiry = item;
//             if (currentExpiry != null) {
//               //print(odController.selectedRight.first);
//               odController.getStrikePriceData(
//                   expiry: currentExpiry!,
//                   right: odController.selectedRight.first);
//               currentStrike = null;
//             }
//           });
//         });
//   }
//
//   // Widget testDropDown() {
//   //   final List<String> genderItems = [
//   //     'Male',
//   //     'Female',
//   //   ];
//   //   String? selectedValue;
//   //   return Center(
//   //     child: Container(
//   //       width: 150,
//   //       height: 30,
//   //       child: DropdownButtonFormField2<String>(
//   //         decoration: const InputDecoration(
//   //           labelText: "  Select Expiry",
//   //           labelStyle: TextStyle(fontSize: 12),
//   //           alignLabelWithHint: true,
//   //           floatingLabelBehavior: FloatingLabelBehavior.auto,
//   //           // Add Horizontal padding using menuItemStyleData.padding so it matches
//   //           // the menu padding when button's width is not specified.
//   //           contentPadding: EdgeInsets.symmetric(vertical: 0),
//   //           border: OutlineInputBorder(
//   //             borderRadius: BorderRadius.all(Radius.circular(8)),
//   //           ),
//   //           // Add more decoration..
//   //         ),
//   //         hint: const Text(
//   //           "hi",
//   //           style: TextStyle(fontSize: 14),
//   //         ),
//   //         items: genderItems
//   //             .map((item) => DropdownMenuItem<String>(
//   //                   value: item,
//   //                   child: Text(
//   //                     item,
//   //                     style: const TextStyle(
//   //                       fontSize: 14,
//   //                     ),
//   //                   ),
//   //                 ))
//   //             .toList(),
//   //         validator: (value) {
//   //           if (value == null) {
//   //             return 'Please select gender.';
//   //           }
//   //           return null;
//   //         },
//   //         onChanged: (value) {
//   //           //Do something when selected item is changed.
//   //         },
//   //         onSaved: (value) {
//   //           selectedValue = value.toString();
//   //         },
//   //         buttonStyleData: const ButtonStyleData(
//   //           padding: EdgeInsets.only(right: 8),
//   //         ),
//   //         iconStyleData: const IconStyleData(
//   //           icon: Icon(
//   //             Icons.arrow_drop_down,
//   //           ),
//   //           iconSize: 24,
//   //         ),
//   //         dropdownStyleData: DropdownStyleData(
//   //           decoration: BoxDecoration(
//   //             borderRadius: BorderRadius.circular(15),
//   //           ),
//   //         ),
//   //         menuItemStyleData: const MenuItemStyleData(
//   //           padding: EdgeInsets.symmetric(horizontal: 16),
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }
//
//   //todo
//   Widget testDropDown2() {
//     return Center(
//       child: Container(
//         width: 120,
//         height: 30,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: DropdownButtonFormField<String>(
//           alignment: Alignment.bottomCenter,
//           value: 'Option 1',
//           decoration: InputDecoration(
//             border: OutlineInputBorder(),
//             contentPadding: EdgeInsets.symmetric(horizontal: 10),
//           ),
//           items: ['Option 1', 'Option 2', 'Option 3'].map((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//           onChanged: (newValue) {
//             setState(() {});
//           },
//         ),
//       ),
//     );
//   }
//
//   SegmentedButton<String> buildCandleTimeSelector() {
//     return SegmentedButton(
//         style: ButtonStyle(
//           shape: WidgetStateProperty.all<RoundedRectangleBorder>(
//               RoundedRectangleBorder(
//             borderRadius:
//                 BorderRadius.circular(0), // This makes the shape rectangular
//             side: const BorderSide(), // Optional: Add a border color
//           )),
//         ),
//         showSelectedIcon: false,
//         segments: const [
//           ButtonSegment(value: "1m", label: Text("1m")),
//           ButtonSegment(value: "5m", label: Text("5m")),
//           ButtonSegment(value: "15m", label: Text("15m"))
//         ],
//         selected: odController.selectedCandleTimeFrame,
//         onSelectionChanged: (value) {
//           setState(() {
//             odController.updateCandleTimeFrame(value);
//             int timeFrame = convertTimeFrameToMinutes(
//                 odController.selectedCandleTimeFrame.first);
//             odController.aggregateOHLC(
//                 odController.ohlcDataListOriginal, timeFrame);
//           });
//         });
//   }
//
//   //trying to make a popup menu for time frame selection instead of segmented button
//   Widget timeFrameNew() {
//     return Container(
//       child: PopupMenuButton(
//         style: ButtonStyle(
//           shape: WidgetStateProperty.all<RoundedRectangleBorder>(
//               RoundedRectangleBorder(
//             borderRadius:
//                 BorderRadius.circular(8), // This makes the shape rectangular
//             side: const BorderSide(color: Colors.white),
//           )),
//         ),
//         tooltip: "Candle Timeframe",
//         initialValue: "1",
//         itemBuilder: (BuildContext context) {
//           return const [
//             PopupMenuItem(child: Text("1")),
//             PopupMenuItem(child: Text("2")),
//             PopupMenuItem(child: Text("3")),
//           ];
//         },
//         child: Text(
//           "1m",
//           style: TextStyle(fontWeight: FontWeight.w600),
//         ),
//       ),
//     );
//   }
//
//   Widget searchStock() {
//     return const Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Icon(Icons.search),
//         SizedBox(width: 5),
//         Text(
//           "BANK NIFTY",
//           style: TextStyle(fontWeight: FontWeight.w500),
//           textAlign: TextAlign.center,
//         ),
//       ],
//     );
//   }
//
// // Text buildStockName() => const Text(
// //       "BANKNIFTY",
// //       style: TextStyle(fontWeight: FontWeight.w500),
// //     );
// //
// // IconButton buildSearchIcon() =>
// //     IconButton(onPressed: () {}, icon: const Icon(Icons.search));
//
// // CircleAvatar buildCircleAvatar() {
// //   return const CircleAvatar(
// //       backgroundColor: Colors.transparent,
// //       maxRadius: 15,
// //       child: Icon(Icons.person));
// // }
// }
