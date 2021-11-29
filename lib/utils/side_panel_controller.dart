import 'package:flutter/material.dart';
import 'package:insu_web/utils/side_panel.dart';

class SidePanelController {
  static GlobalKey<SidePanelState>? _key;

  static GlobalKey<SidePanelState> init() => _key = GlobalKey<SidePanelState>();

  static bool get isCollapsed => _key!.currentState!.isCollapsed;

  static void open() {
    _key!.currentState!.open();
  }

  static void close() {
    _key!.currentState!.close();
  }
}
