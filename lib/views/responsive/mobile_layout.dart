import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../layout/app_bar.dart';
import '../layout/chart_area.dart';
import '../layout/left_sidebar.dart';

class MobileBody extends StatelessWidget {
  const MobileBody({super.key});

  @override
  Widget build(BuildContext context) {
    Color barColor = Theme.of(context).primaryColor;
    return Column(
      children: [
        ///app bar
        Container(
          margin: const EdgeInsets.only(bottom: defaultPadding),
          height: appBarHeight,
          color: barColor,
          child: const MyAppBar(),
        ),

        ///rest of the body except appBar
        Expanded(
          child: Row(
            children: [
              ///left Side Bar
              Container(
                width: sideBarWidth,
                color: barColor,
                child: const LeftSidebar(),
              ),

              Container(
                margin: const EdgeInsets.fromLTRB(
                    defaultPadding, 0, 0, 0),
                width: MediaQuery.of(context).size.width -
                    (sideBarWidth) -
                    (defaultPadding),
                height: MediaQuery.of(context).size.height -
                    (appBarHeight) -
                    (defaultPadding),
                color: Theme.of(context).canvasColor,
                child: const ChartArea(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}