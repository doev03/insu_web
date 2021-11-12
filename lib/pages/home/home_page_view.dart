import 'package:flutter/material.dart';
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
            items: [
              SidePanelItem(
                icon: '',
                title: 'Home',
                onTap: () {},
                collapsedWidth: 50,
                width: 200,
              ),
              SidePanelItem(
                icon: 'assets/icons/profile.svg',
                title: 'Profile',
                onTap: () {},
                collapsedWidth: 50,
                width: 200,
              ),
              SidePanelItem(
                icon: 'assets/icons/road_map.svg',
                title: 'Road Map',
                onTap: () {},
                collapsedWidth: 50,
                width: 200,
              ),
              SidePanelItem(
                icon: 'assets/icons/white_paper.svg',
                title: 'White Pepper',
                onTap: () {},
                collapsedWidth: 50,
                width: 200,
              ),
              SidePanelItem(
                icon: 'assets/icons/contacts.png',
                title: 'Contacts',
                onTap: () {},
                collapsedWidth: 50,
                width: 200,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
