import "package:flutter/material.dart";
import "package:fno_view/controllers/ohlc_data_controller.dart";
import "package:fno_view/utils/constants.dart";
import "package:get/get.dart";
import "../../controllers/indicator_controller.dart";
import "../widgets/indicator_dialog_box.dart";
import "../widgets/custom_dropdown_button.dart";
import "../widgets/my_text_icon_button.dart";

class MyAppBar extends StatefulWidget {
  const MyAppBar({super.key});

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  OhlcDataController dataController = Get.put(OhlcDataController());

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

  Widget refreshButton() {
    return Obx(() {
      debugPrint(dataController.selectedExpiry.value);
      return IconButton(
          onPressed: () {
            if(
            dataController.selectedExpiry.value != null
                && dataController.selectedRight.value != null
                && dataController.selectedStrike.value != null){
              dataController.fetchOhlcDataFromNetwork(
                  expiry: dataController.selectedExpiry.value!,
                  right: dataController.selectedRight.value!,
                  strike: dataController.selectedStrike.value!);
            } else{
              //todo: show a snackbar or error message.
              debugPrint("can't refresh: one of the values is null");
            }
          },
          icon: const Icon(Icons.refresh));
    });
  }

  Widget expiryDropdown() {
    return Obx((){
      debugPrint("diff ${dataController.expiryDateList}");
      return CustomDropdownButton(
        initialMenuItems: dataController.expiryDateList,
        labelText: "Select Expiry",
        hintText: "Select Expiry",
        width: 150,
        onChanged: (expiry){
          if (expiry != null) {
            if(dataController.selectedExpiry.value != expiry){
              dataController.selectedExpiry(expiry);
            dataController.selectedStrike.value = null; // Reset selectedStrike
            dataController.strikePriceList.clear();
            if (dataController.selectedExpiry.value != null && dataController.selectedRight.value != null){
              dataController.getStrikePriceData(
                  expiry: dataController.selectedExpiry.value!,
                  right: dataController.selectedRight.value!
              );
            }}
          }
        },
      );
    });
  }

  Widget rightDropdown() {
    return Obx(() {
      return CustomDropdownButton(
        initialMenuItems: const ["call", "put"],
        labelText: "Select Right",
        hintText: "Select Right",
        width: 150,
        value: dataController.selectedRight.value, // Add this line
        onChanged: (right) {
          if (right != null) {
            dataController.selectedRight(right);
            dataController.selectedStrike.value = null; // Reset selectedStrike
            dataController.strikePriceList.clear(); // Clear the current list

            // Fetch the new list of strike prices
            if(dataController.selectedRight.value != null && dataController.selectedExpiry.value != null){
              dataController.getStrikePriceData(
                  expiry: dataController.selectedExpiry.value!,
                  right: dataController.selectedRight.value!
              );
            }
          }
        },
      );
    });
  }

  Widget strikeDropdown() {
    return Obx(() {
      debugPrint("diff ${dataController.strikePriceList}");
      // Ensure that the selected strike is in the list
      if (dataController.selectedStrike.value != null &&
          !dataController.strikePriceList.contains(dataController.selectedStrike.value)) {
        dataController.selectedStrike.value = null;
      }

      return CustomDropdownButton(
        initialMenuItems: dataController.strikePriceList,
        labelText: "Select Strike",
        hintText: "Select Strike",
        width: 150,
        value: dataController.selectedStrike.value, // Pass the value here
        onChanged: (strike) {
          dataController.selectedStrike(strike);
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
                  padding: EdgeInsets.all(12),
                  child: Text("Indicators", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                ),
                const SizedBox(height: 20,),
                IndicatorSelectorArea(indicators: supportedIndicatorList),
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

}
