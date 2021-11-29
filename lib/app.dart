import 'package:flutter/material.dart';
import 'package:insu_web/core/app_navigator.dart';
import 'package:insu_web/utils/side_panel.dart';
import 'package:insu_web/utils/side_panel_controller.dart';

import 'config.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Insu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2),
          ),
        ),
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        /*body: ExamplePage(),*/
        body: Stack(
          children: [
            Navigator(
              key: AppNavigator.key,
              initialRoute: 'profile',
              onGenerateRoute: AppNavigator.onGenerateRoute,
            ),
            SidePanel(
              key: SidePanelController.init(),
              items: AppConfig.panelItems,
            ),
            Padding(
              padding: EdgeInsets.only(left: AppConfig.panelCollapsedWidth),
              child: GestureDetector(
                onTap: () {
                  if (!SidePanelController.isCollapsed) SidePanelController.close();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
