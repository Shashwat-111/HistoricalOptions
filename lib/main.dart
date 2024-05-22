import 'package:flutter/material.dart';
import 'package:fno_view/views/pages/main_graph.dart';
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
    return const MaterialApp(
      title: "Options View",
      home: SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyAppBar(),
              MainChart()
            ],
          ),
        ),
      ),
    );
  }
}
