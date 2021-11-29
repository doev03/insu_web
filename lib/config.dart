import 'package:flutter/material.dart';
import 'package:insu_web/core/app_navigator.dart';
import 'package:insu_web/core/constants/colors.dart';
import 'package:insu_web/utils/side_panel_controller.dart';
import 'package:insu_web/utils/side_panel_item.dart';

class AppConfig {
  ///Основная цветовая схема - [AppColors]

  ///Боковая панель - [panelCollapsedWidth], [panelExpandedWidth], [panelItemsOffset], [panelBackgroundColor], [panelItems]

  //Ширина скрытой панели
  static const double panelCollapsedWidth = 55.0;

  //Ширина развернутой панели, не учитывая ширину скрытой
  static const double panelExpandedWidth = 200.0;

  //Отступ между основными элементами
  static const double panelItemsOffset = panelCollapsedWidth * 0.4;

  //Цвет фона панели
  //static const Color panelBackgroundColor = Color(0xFF0F71F2);
  static const Color panelBackgroundColor = Color(0xFF262626);

  //Основные кнопки панели
  static final panelItems = [
    SidePanelItem(
      icon: 'assets/icons/profile.svg',
      title: 'Profile',
      pageName: 'profile',
      onTap: (context) {
        AppNavigator.key.currentState!.pushReplacementNamed('profile');
        SidePanelController.close();
      },
    ),
    SidePanelItem(
      icon: 'assets/icons/roadmap.svg',
      title: 'Roadmap',
      pageName: 'roadmap',
      onTap: (context) {
        AppNavigator.key.currentState!.pushReplacementNamed('roadmap');
        SidePanelController.close();
      },
    ),
    SidePanelItem(
      icon: 'assets/icons/white_paper.svg',
      title: 'Manifesto',
      pageName: 'manifesto',
      onTap: (context) {
        AppNavigator.key.currentState!.pushReplacementNamed('manifesto');
        SidePanelController.close();
      },
    ),
    SidePanelItem(
      icon: 'assets/icons/contacts.svg',
      title: 'Contacts',
      pageName: 'contacts',
      onTap: (context) {
        AppNavigator.key.currentState!.pushReplacementNamed('contacts');
        SidePanelController.close();
      },
    ),
  ];
}
