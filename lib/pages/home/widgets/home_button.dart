import 'dart:math' as math;

import 'package:flutter/material.dart';

class HomeButton extends StatefulWidget {
  const HomeButton({
    Key? key,
    required this.onTap,
    this.color = Colors.blue,
    required this.page,
  }) : super(key: key);

  final GestureTapCallback onTap;
  final Color color;
  final Widget page;

  @override
  _HomeButtonState createState() => _HomeButtonState();
}

class _HomeButtonState extends State<HomeButton> with TickerProviderStateMixin {
  late AnimationController animationController;
  late AnimationController pageHideAnimationController;
  late AnimationController pageContentAnimationController;
  late Animation pageHideAnimation;
  late Animation pageContentAnimation;
  OverlayEntry? _overlayEntry;
  Offset hoverOffset = Offset(0.0, 0.0);
  bool isPressed = false;
  late ValueNotifier<Color> color;

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 100), upperBound: 0.1);
    pageHideAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    pageContentAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    pageHideAnimation = CurvedAnimation(parent: pageHideAnimationController, curve: Curves.easeInOutQuart);
    pageContentAnimation = CurvedAnimation(parent: pageContentAnimationController, curve: Curves.easeInOutQuart);
    pageHideAnimationController.addListener(() {
      if (!pageContentAnimationController.isAnimating && pageHideAnimationController.value > 0.2) {
        pageContentAnimationController.forward();
      }
    });

    color = ValueNotifier<Color>(widget.color);
    super.initState();
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        left: 0,
        top: 0,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Material(
          color: Colors.transparent,
          child: GestureDetector(
            onTap: () {
              isPressed = !isPressed;

              if (isPressed) {
                pageHideAnimationController.forward();
              } else {
                pageHideAnimationController.reverse().whenComplete(() => _overlayEntry!.remove());
                pageContentAnimationController.reverse();
              }
            },
            child: Stack(
              children: [
                AnimatedBuilder(
                  animation: pageHideAnimation,
                  builder: (context, child) {
                    return ShaderMask(
                      blendMode: BlendMode.overlay,
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[Colors.black, Colors.transparent],
                          stops: [pageHideAnimation.value < 0.5 ? 0 : (pageHideAnimation.value - 0.5) * 2, pageHideAnimation.value < 0.5 ? pageHideAnimation.value * 2 : 1],
                          tileMode: TileMode.mirror,
                        ).createShader(bounds);
                      },
                      child: Container(height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width, color: Colors.transparent,),
                    );
                  },
                ),
                AnimatedBuilder(
                  animation: pageContentAnimation,
                  builder: (context, child) {
                    return ShaderMask(
                      blendMode: BlendMode.dstOut,
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[Colors.transparent, Colors.black],
                          stops: [(pageContentAnimation.value - 0.5) * 0.4, pageContentAnimation.value],
                          tileMode: TileMode.mirror,
                        ).createShader(bounds);
                      },
                      child: child,
                    );
                  },
                  child: widget.page,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) {
        hoverOffset = event.localPosition;
        if (!isPressed) animationController.animateTo(0.05, duration: Duration(milliseconds: 100));
        //color.value = color.value.withOpacity(1.0);
      },
      onExit: (event) {
        hoverOffset = event.localPosition;
        if (!isPressed) animationController.reverse();
        //color.value = color.value.withOpacity(0.5);
      },
      onHover: (event) {
        //print(event.localPosition);
      },
      child: GestureDetector(
        onTap: () {
          widget.onTap();

          isPressed = !isPressed;
          animationController.animateTo(0.1, duration: Duration(milliseconds: 100)).whenComplete(() {
            Future.delayed(Duration(milliseconds: 150), () => animationController.animateTo(0, duration: Duration(milliseconds: 150)));
          });

          _overlayEntry = _createOverlayEntry();
          Overlay.of(context)!.insert(_overlayEntry!);
          pageHideAnimationController.forward();
        },
        child: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            return Transform.scale(
              scale: 1 - animationController.value,
              child: Container(
                height: 200,
                width: 400,
                decoration: BoxDecoration(
                  color: color.value,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 20 - animationController.value * 150,
                    )
                  ],
                ),
                child: child,
              ),
            );
          },
          child: Icon(Icons.flutter_dash),
        ),
      ),
    );
  }
}

class HoverPainter extends CustomPainter {
  final Color color;
  final double progress;
  final Offset hoverOffset;

  const HoverPainter({this.color = Colors.blue, required this.progress, required this.hoverOffset});

  @override
  void paint(Canvas canvas, Size size) {
    double diagonal = math.sqrt(math.pow(size.width, 2) + math.pow(size.height, 2));
    canvas.drawCircle(hoverOffset, progress * diagonal, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PageOpeningClipper extends CustomClipper<RRect> {
  final Offset center;
  final double progress;
  final double targetWidth;
  final double targetHeight;

  PageOpeningClipper({required this.center, required this.progress, required this.targetWidth, required this.targetHeight});

  @override
  RRect getClip(Size size) {
    RRect rRect = RRect.fromRectAndRadius(Rect.fromCenter(center: center, width: targetWidth * progress, height: targetHeight * progress), Radius.circular((1 - progress) * 25));

    return rRect;
  }

  @override
  bool shouldReclip(covariant CustomClipper<RRect> oldClipper) {
    return true;
  }
}
