import 'package:flutter/material.dart';
import 'package:fno_view/controllers/chart_setting_controller.dart';
import 'package:fno_view/utils/helper_functions.dart';
import 'package:fno_view/views/responsive/responsive.dart';
import 'package:get/get.dart';

import '../../controllers/ohlc_data_controller.dart';
import '../../controllers/trackball_controller.dart';

class TimeFrameSelectorButton extends StatefulWidget {
  const TimeFrameSelectorButton({super.key});

  @override
  State<TimeFrameSelectorButton> createState() => _TimeFrameSelectorButtonState();
}

class _TimeFrameSelectorButtonState extends State<TimeFrameSelectorButton> {
  String selectedValue = "1m";
  Map<String, VoidCallback> timeFrameWithFunction = {
    "1m" : (){
      changeTimeFrame(CandleTimeFrame.oneMinute);
    },
    "5m" : (){
      changeTimeFrame(CandleTimeFrame.fiveMinute);
    },
    "15m" : (){
      changeTimeFrame(CandleTimeFrame.fifteenMinute);
    },
  };
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileBody: mobileButton(),
      desktopBody: desktopButton(),
    );
  }

  Widget mobileButton(){
    return IconButton(
        onPressed: (){
          setState(() {
            switch(selectedValue){
              case "1m" : selectedValue = "5m";
              case "5m" : selectedValue = "15m";
              case "15m" : selectedValue = "1m";
            }
            timeFrameWithFunction[selectedValue]!();
          });
        },
        icon: Text(selectedValue,style: TextStyle(fontWeight: FontWeight.w500),)
    );
  }

  Widget desktopButton(){
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
                  decoration: BoxDecoration(shape: BoxShape.rectangle, borderRadius: const BorderRadius.all(Radius.circular(8)),color: selectedValue == time ? Theme.of(context).highlightColor : Theme.of(context).primaryColor),
                  child: Center(child: Text(time, style: TextStyle(fontWeight: selectedValue == time ? FontWeight.bold : null))),
                ))).toList()
        ),
      ),
    );
  }
}

changeTimeFrame(CandleTimeFrame candleTimeFrame){
  OhlcDataController dataController = Get.put(OhlcDataController());
  ChartSettingController chartSettingController = Get.put(ChartSettingController());
  TrackballController trackballController = Get.put(TrackballController());
  chartSettingController.updateCandleTimeFrame(candleTimeFrame);

  //this is required as when timeFrame changes it may happen that the previous
  // index is now out-of-bound for the new timeframe, so making it to zero on change.
  trackballController.trackballIndex.value = 0;

  int timeFrame = HelperFunctions.convertTimeFrameToMinutes(
      chartSettingController.selectedCandleTimeFrame.value);
  aggregateOHLC(dataController.ohlcDataListOriginal, timeFrame);
}