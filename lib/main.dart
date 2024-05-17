import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fno_view/views/pages/mainGraph.dart';
import 'package:fno_view/views/widgets/my_appbar.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("inside 1st build");
    }
    return const MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyAppBar(),
              SizedBox(
                child: SizedBox(
                  height: 600,
                  width: 1000,
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: MainChart(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
