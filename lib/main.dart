import 'package:flutter/material.dart';
import 'package:fno_view/views/layout/app_bar.dart';
import 'package:fno_view/views/layout/chart_area.dart';
import 'package:fno_view/views/layout/main_graph.dart';
import 'package:fno_view/views/widgets/my_appbar.dart';
import 'package:get/get.dart';
import 'controllers/option_controller.dart';


void main() {
  runApp(const MyApp());
}

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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue[600]!)
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[700],
        body: Column(
          children: [

            ///app bar
            Container(
              margin: const EdgeInsets.only(bottom: 5),
              height: 52,
              color: Colors.white,
              child: MyAppBar(),
            ),

            Container(
              height: MediaQuery.of(context).size.height-52-5,
              child: Row(
                children: [

                  ///left Side Bar
                  Container(
                    width: 52,
                    color: Colors.white,
                  ),

                  Column(
                    children: [

                      ///Chart Area
                      Container(
                        margin: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                        width: MediaQuery.of(context).size.width-52-52-10,
                        height: MediaQuery.of(context).size.height-52-38-10,
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
                        height: 38,
                        width: MediaQuery.of(context).size.width-52-52-10,
                        color: Colors.white,
                      )
                    ],
                  ),

                  ///right side bar
                  ///todo add a condition to hide this when on small device
                  Container(
                    width: 52,
                    color: Colors.white,
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
