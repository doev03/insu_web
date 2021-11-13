import 'package:flutter/material.dart';
import 'package:insu_web/utils/side_panel_item.dart';

class AppConfig {
  ///Боковая панель - [panelCollapsedWidth], [panelExpandedWidth], [panelItemsOffset], [panelBackgroundColor], [panelItems]

  //Ширина скрытой панели
  static const double panelCollapsedWidth = 70.0;

  //Ширина развернутой панели, не учитывая ширину скрытой
  static const double panelExpandedWidth = 200.0;

  //Отступ между основными элементами
  static const double panelItemsOffset = panelCollapsedWidth * 0.5;

  //Цвет фона панели
  static const Color panelBackgroundColor = Color(0xFF262626);

  //Основные кнопки панели
  static final panelItems = [
    SidePanelItem(
      icon: 'assets/icons/profile.png',
      title: 'Profile',
      onTap: () {},
    ),
    SidePanelItem(
      icon: 'assets/icons/roadmap.png',
      title: 'Roadmap',
      onTap: () {},
    ),
    SidePanelItem(
      icon: 'assets/icons/white_paper.png',
      title: 'White Paper',
      onTap: () {},
    ),
    SidePanelItem(
      icon: 'assets/icons/contacts.png',
      title: 'Contact',
      onTap: () {},
    ),
  ];
}
