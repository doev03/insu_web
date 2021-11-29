import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insu_web/core/app_navigator.dart';
import 'package:insu_web/core/constants/colors.dart';
import 'package:insu_web/utils/side_panel.dart';

class LogoButton extends StatefulWidget {
  const LogoButton({Key? key, required this.animation}) : super(key: key);
  final Animation animation;

  @override
  _LogoButtonState createState() => _LogoButtonState();
}

class _LogoButtonState extends State<LogoButton> {
  void _navigatorListener() {
    if (AppNavigator.currentRouteName.value == '/')
      setState(() {});
    else if (AppNavigator.prevRouteName.value == '/') setState(() {});
  }

  @override
  void initState() {
    AppNavigator.currentRouteName.addListener(_navigatorListener);
    super.initState();
  }

  @override
  void dispose() {
    AppNavigator.currentRouteName.removeListener(_navigatorListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pageName = AppNavigator.currentRouteName.value;

    return CustomPaint(
      painter: MakeCircle(
        offset: widget.animation.value * MediaQuery.of(context).size.height * 2,
        targetOffset: MediaQuery.of(context).size.height,
        color: pageName == '/' ? AppColors.selectedIcon : AppColors.icon,
      ),
      child: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/logo.svg',
          color: pageName == '/' ? AppColors.selectedIcon : AppColors.icon,
        ),
        onPressed: () {
          if (pageName != '/') AppNavigator.key.currentState!.pushReplacementNamed('/');
        },
      ),
    );
  }
}

class MakeCircle extends CustomPainter {
  final double strokeWidth;
  final StrokeCap strokeCap;
  final double offset;
  final double targetOffset;
  final Color color;

  MakeCircle({
    this.strokeCap = StrokeCap.square,
    this.strokeWidth = 3.0,
    this.offset = 0,
    required this.targetOffset,
    this.color = AppColors.icon,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()..addOval(Rect.fromPoints(Offset(0 - offset, 0 - offset), Offset(size.width + offset, size.height + offset)));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}