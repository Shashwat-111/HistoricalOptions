import 'package:flutter/material.dart';
import 'package:fno_view/views/widgets/timeframe_selector_button.dart';
import 'package:get/get.dart';
import '../../controllers/option_controller.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  OptionDataController odController = Get.put(OptionDataController());

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const TimeFrameSelectorButton(),
        const Spacer(),
        IconButton(
            onPressed: () {},
            tooltip: "settings",
            icon: const Icon(Icons.settings_sharp))
      ],
    );
  }
}

// old time Selector button
//   SegmentedButton<String> buildCandleTimeSelector() {
//     return SegmentedButton(
//         style: ButtonStyle(
//           shape: WidgetStateProperty.all<RoundedRectangleBorder>(
//               RoundedRectangleBorder(
//                 borderRadius:
//                 BorderRadius.circular(0), // This makes the shape rectangular
//                 side: const BorderSide(), // Optional: Add a border color
//               )),
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
// }

