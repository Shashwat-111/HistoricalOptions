import 'package:flutter/material.dart';
import 'package:fno_view/utils/constants.dart';
import 'package:fno_view/views/layout/app_bar.dart';
import 'package:fno_view/views/layout/bottom_bar.dart';
import 'package:fno_view/views/layout/chart_area.dart';
import 'package:fno_view/views/layout/left_sidebar.dart';
import 'package:fno_view/views/layout/right_sidebar.dart';
import 'package:get/get.dart';
import 'controllers/option_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  OptionDataController odController = Get.put(OptionDataController());
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Historical Options",
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue[600]!),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[700],
        body: Column(
          children: [
            ///app bar
            Container(
              margin: const EdgeInsets.only(bottom: defaultPadding),
              height: appBarHeight,
              color: Colors.white,
              child: const MyAppBar(),
            ),

            ///rest of the body except appBar
            SizedBox(
              height: MediaQuery.of(context).size.height -
                  appBarHeight -
                  defaultPadding,
              child: Row(
                children: [
                  ///left Side Bar
                  Container(
                    width: sideBarWidth,
                    color: Colors.white,
                    child: LeftSidebar(),
                  ),

                  Column(
                    children: [
                      ///Chart Area
                      Container(
                        margin: const EdgeInsets.fromLTRB(
                            defaultPadding, 0, defaultPadding, defaultPadding),
                        width: MediaQuery.of(context).size.width -
                            (sideBarWidth * 2) -
                            (defaultPadding * 2),
                        height: MediaQuery.of(context).size.height -
                            (appBarHeight + bottomBarHeight) -
                            (defaultPadding * 2),
                        color: Colors.white,
                        child: const Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(child: ChartArea()),

                            ///to be uncommented and used when side by side
                            ///comparison of chart feature would be added.
                            // Container(width: 5,color: Colors.grey[700],),
                            // Expanded(child: ChartArea()),
                          ],
                        ),
                      ),

                      ///Bottom Bar
                      ///todo add a condition to hide this when on small device
                      Container(
                        height: bottomBarHeight,
                        width: MediaQuery.of(context).size.width -
                            (sideBarWidth * 2) -
                            (defaultPadding * 2),
                        color: Colors.white,
                        child: const BottomBar(),
                      )
                    ],
                  ),

                  ///right side bar
                  ///todo add a condition to hide this when on small device
                  Container(
                    width: sideBarWidth,
                    color: Colors.white,
                    child: RightSidebar(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Old MyApp
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   OptionDataController odController = Get.put(OptionDataController());
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     if (width<1000){
//       odController.updateDeviceSize(true);
//     }
//     if (width>=1000){
//       odController.updateDeviceSize(false);
//     }
//     return Obx(
//       () => SizedBox(
//         height: 792,
//         width: 1200,
//         child: MaterialApp(
//           debugShowCheckedModeBanner: false,
//           theme: odController.darkMode.value,
//           title: "HistoricalOptions.in",
//           home: const SafeArea(
//             child: Scaffold(
//               body: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   MyAppBar(),
//                   MainChart(),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
