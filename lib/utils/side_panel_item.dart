import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insu_web/config.dart';

class SidePanelItem extends StatefulWidget {
  const SidePanelItem({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.title,
    this.height = 50.0,
    this.collapsedWidth = AppConfig.panelCollapsedWidth,
    this.width = AppConfig.panelExpandedWidth,
  }) : super(key: key);

  final GestureTapCallback onTap;
  final String icon;
  final String title;
  final double height;
  final double collapsedWidth;
  final double width;

  @override
  _SidePanelItemState createState() => _SidePanelItemState();
}

class _SidePanelItemState extends State<SidePanelItem> with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String iconType = '';
    if (widget.icon.length > 3) {
      iconType = widget.icon.substring(widget.icon.length - 3, widget.icon.length);
    }

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
        );
    }

    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (event) {
          animationController.forward();
        },
        onExit: (event) {
          animationController.reverse();
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
                      padding: EdgeInsets.only(left: 10, right: 10),
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
