import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:insu_web/config.dart';
import 'package:insu_web/core/constants/colors.dart';

import '../core/app_navigator.dart';
import 'logo_button.dart';
import 'side_panel_item.dart';

class SidePanel extends StatefulWidget {
  const SidePanel({
    Key? key,
    this.collapsedWidth = AppConfig.panelCollapsedWidth,
    this.width = AppConfig.panelExpandedWidth,
    this.items,
    this.backgroundColor = AppConfig.panelBackgroundColor,
  }) : super(key: key);

  final double collapsedWidth;
  final double width;
  final List<SidePanelItem>? items;
  final Color backgroundColor;

  @override
  SidePanelState createState() => SidePanelState();
}

class SidePanelState extends State<SidePanel> with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  late List<SidePanelItem> items;

  bool isCollapsed = true;

  @override
  void initState() {
    if (widget.items == null)
      items = AppConfig.panelItems;
    else
      items = widget.items!;

    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animation = CurvedAnimation(parent: animationController, curve: Curves.easeInQuint);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void open() {
    isCollapsed = false;
    animationController.forward();
  }

  void close() {
    isCollapsed = true;
    animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final pageName = AppNavigator.currentRouteName.value;

    return Align(
      alignment: Alignment.topLeft,
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return ClipRect(
            clipper: CustomDrawerClipper(
              targetWidth: widget.collapsedWidth + widget.width * animation.value,
            ),
            child: Container(
              color: widget.backgroundColor,
              width: widget.collapsedWidth + widget.width,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 70),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: widget.items!,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            if (isCollapsed) {
                              open();
                            } else {
                              close();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 20,
                    child: Container(
                      width: widget.collapsedWidth,
                      alignment: Alignment.topCenter,
                      child: IconButton(
                        icon: AnimatedIcon(
                          progress: animation,
                          icon: AnimatedIcons.menu_arrow,
                          color: AppColors.icon,
                        ),
                        onPressed: () {
                          if (isCollapsed) {
                            open();
                          } else {
                            close();
                          }
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    left: widget.width * animation.value - 42 * animation.value,
                    child: Container(
                      width: widget.collapsedWidth + 42 * animation.value,
                      height: widget.collapsedWidth,
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 42.0 + 42 * animation.value,
                        height: 42.0,
                        child: LogoButton(
                          animation: animation,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CustomDrawerClipper extends CustomClipper<Rect> {
  final double targetWidth;

  const CustomDrawerClipper({required this.targetWidth});

  @override
  Rect getClip(Size size) {
    Rect rect = Rect.fromPoints(Offset(0, 0), Offset(targetWidth, size.height));

    return rect;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return true;
  }
}
