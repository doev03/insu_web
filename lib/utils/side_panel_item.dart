import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'icon_type.dart';

class SidePanelItem extends StatefulWidget {
  const SidePanelItem({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.title,
    this.height = 50.0,
    required this.collapsedWidth,
    required this.width,
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

class _SidePanelItemState extends State<SidePanelItem> {
  @override
  Widget build(BuildContext context) {
    final iconType = widget.icon.substring(widget.icon.length - 3, widget.icon.length);
    Widget icon;
    switch (iconType) {
      case 'svg':
        icon = SvgPicture.asset(widget.icon);
        break;
      default:
        icon = Image.asset(widget.icon, );
    }

    return Padding(
      padding: EdgeInsets.only(top: widget.collapsedWidth * 0.1, bottom: widget.collapsedWidth * 0.1),
      child: InkWell(
        child: Container(
          height: widget.height,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: widget.collapsedWidth,
                height: widget.height,
                child: icon,
              ),
              SizedBox(
                width: widget.width * 0.05,
              ),
              FittedBox(child: Text(widget.title, style: TextStyle(fontSize: 24, color: Colors.white),)),
            ],
          ),
        ),
      ),
    );
  }
}
