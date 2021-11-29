import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insu_web/config.dart';
import 'package:insu_web/core/constants/colors.dart';

import '../core/app_navigator.dart';

class SidePanelItem extends StatefulWidget {
  const SidePanelItem({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.title,
    this.height = 35.0,
    this.collapsedWidth = AppConfig.panelCollapsedWidth,
    this.width = AppConfig.panelExpandedWidth,
    required this.pageName,
  }) : super(key: key);

  final Function(BuildContext context) onTap;
  final String icon;
  final String title;
  final double height;
  final double collapsedWidth;
  final double width;
  final String pageName;

  @override
  _SidePanelItemState createState() => _SidePanelItemState();
}

class _SidePanelItemState extends State<SidePanelItem> with TickerProviderStateMixin {
  late AnimationController animationController;

  void _navigatorListener() {
    if (AppNavigator.currentRouteName.value == widget.pageName)
      setState(() {});
    else if (AppNavigator.prevRouteName.value == widget.pageName) setState(() {});
  }

  @override
  void initState() {
    AppNavigator.currentRouteName.addListener(_navigatorListener);
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    super.initState();
  }

  @override
  void dispose() {
    AppNavigator.currentRouteName.removeListener(_navigatorListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String iconType = '';
    if (widget.icon.length > 3) {
      iconType = widget.icon.substring(widget.icon.length - 3, widget.icon.length);
    }

    final pageName = AppNavigator.currentRouteName.value;
    final isSelected = pageName == widget.pageName;

    final Color iconColor = isSelected ? AppColors.selectedIcon : AppColors.icon;

    Widget icon;
    switch (iconType) {
      case '':
        icon = SizedBox(
          width: widget.collapsedWidth,
          height: widget.height,
        );
        break;
      case 'svg':
        icon = SvgPicture.asset(
          widget.icon,
          allowDrawingOutsideViewBox: true,
          excludeFromSemantics: true,
          cacheColorFilter: true,
          color: iconColor,
        );
        break;
      default:
        icon = Image.asset(
          widget.icon,
          filterQuality: FilterQuality.high,
          gaplessPlayback: true,
          excludeFromSemantics: true,
          isAntiAlias: true,
          matchTextDirection: true,
          color: iconColor,
        );
    }

    return GestureDetector(
      onTap: () {
        if (!isSelected) widget.onTap(context);
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (event) {
          if (!isSelected) animationController.forward();
        },
        onExit: (event) {
          if (!isSelected) animationController.reverse();
        },
        child: AnimatedBuilder(
          animation: animationController,
          builder: (BuildContext context, Widget? child) {
            return Container(
              height: widget.height + AppConfig.panelItemsOffset,
              width: widget.width + widget.collapsedWidth,
              padding: EdgeInsets.only(bottom: animationController.value * 10.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: widget.collapsedWidth,
                    height: widget.height,
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: icon,
                    ),
                  ),
                  SizedBox(
                    width: widget.width * 0.05,
                  ),
                  FittedBox(
                    child: Text(
                      widget.title,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
