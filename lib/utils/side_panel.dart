import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insu_web/config.dart';

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
                      SizedBox(height: widget.collapsedWidth),
                      SizedBox(height: widget.collapsedWidth),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: widget.items!,
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
                          color: Colors.white,
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
                        child: CustomPaint(
                          painter: MakeCircle(offset: animation.value * MediaQuery.of(context).size.height, targetOffset: MediaQuery.of(context).size.height),
                          child: Padding(
                            padding: EdgeInsets.all(7),
                            child: SvgPicture.asset('assets/icons/logo.svg'),
                          ),
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

class MakeCircle extends CustomPainter {
  final double strokeWidth;
  final StrokeCap strokeCap;
  final double offset;
  final double targetOffset;

  MakeCircle({this.strokeCap = StrokeCap.square, this.strokeWidth = 3.0, this.offset = 0, required this.targetOffset});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity((1.0 - (offset / targetOffset) * 2).clamp(0.0, 1.0))
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()..addOval(Rect.fromPoints(Offset(0 - offset, 0 - offset), Offset(size.width + offset, size.height + offset)));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
