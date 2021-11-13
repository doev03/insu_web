import 'package:flutter/material.dart';
import 'package:insu_web/config.dart';
import 'package:insu_web/utils/side_panel.dart';
import 'package:insu_web/utils/side_panel_item.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  final sidePanelKey = GlobalKey<SidePanelState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Stack(
        children: [
          SidePanel(
            items: AppConfig.panelItems,
          ),
          Positioned(
            left: AppConfig.panelCollapsedWidth + 20,
            child: SizedBox(),
          ),
        ],
      ),
    );
  }
}
