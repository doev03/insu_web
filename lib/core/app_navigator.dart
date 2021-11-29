import 'package:flutter/material.dart';
import 'package:insu_web/pages/contacts/contacts_page.dart';
import 'package:insu_web/pages/home/home_page_view.dart';
import 'package:insu_web/pages/manifest/manifesto_page.dart';
import 'package:insu_web/pages/profile/profile_page.dart';
import 'package:insu_web/pages/roadmap/roadmap_page.dart';

class AppNavigator {
  AppNavigator._();

  static final key = GlobalKey<NavigatorState>();
  static final prevRouteName = ValueNotifier('/');
  static final currentRouteName = ValueNotifier('/');

  static Route onGenerateRoute(RouteSettings settings) {
    if (settings.name != null) {
      prevRouteName.value = currentRouteName.value;
      currentRouteName.value = settings.name!;
    }

    late Widget page;

    switch (settings.name) {
      case '/':
        page = HomePageView();
        break;
      case 'profile':
        page = ProfilePage();
        break;
      case 'roadmap':
        page = RoadmapPage();
        break;
      case 'manifesto':
        page = ManifestoPage();
        break;
      case 'contacts':
        page = ContactsPage();
        break;
    }

    return MaterialPageRoute<dynamic>(
      builder: (context) {
        return page;
      },
      settings: settings,
    );
  }
}
