import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../layout/app_bar.dart';
import '../layout/bottom_bar.dart';
import '../layout/chart_area.dart';
import '../layout/left_sidebar.dart';
import '../layout/right_sidebar.dart';

class DesktopBody extends StatelessWidget {
  const DesktopBody({super.key});
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
        SizedBox(
          height: MediaQuery.of(context).size.height -
              appBarHeight -
              defaultPadding,
          child: Row(
            children: [
              ///left Side Bar
              Container(
                width: sideBarWidth,
                color: barColor,
                child: const LeftSidebar(),
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
                    color: Theme.of(context).canvasColor,
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
                    color: barColor,
                    child: const BottomBar(),
                  )
                ],
              ),

              ///right side bar
              ///todo add a condition to hide this when on small device
              Container(
                width: sideBarWidth,
                color: barColor,
                child: const RightSidebar(),
              )
            ],
          ),
        ),
      ],
    );
  }
}
