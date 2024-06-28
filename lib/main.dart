import 'package:flutter/material.dart';
import 'package:fno_view/views/pages/main_graph.dart';
import 'package:fno_view/views/widgets/my_appbar.dart';
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
    var width = MediaQuery.of(context).size.width;
    if (width<1000){
      odController.updateDeviceSize(true);
    }
    if (width>=1000){
      odController.updateDeviceSize(false);
    }
    return Obx(
      () => SizedBox(
        height: 792,
        width: 1200,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: odController.darkMode.value,
          title: "HistoricalOptions.in",
          home: const SafeArea(
            child: Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyAppBar(),
                  MainChart(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

