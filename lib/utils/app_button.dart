import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  final Function onTap;
  final String title;
  final Duration duration;

  //final Curve curve;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final Color? color;
  final bool? wGradient;
  final List<Color>? gradientColors;
  final Alignment? beginGradient;
  final Alignment? endGradient;
  final TextStyle titleStyle;
  final bool? isLoading;

  const AppButton({
    required this.title,
    required this.onTap,
    this.duration = const Duration(milliseconds: 100),
    //this.curve,
    this.width,
    this.height,
    this.borderRadius,
    this.boxShadow,
    this.color,
    this.wGradient,
    this.gradientColors,
    this.beginGradient,
    this.endGradient,
    this.titleStyle = const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
    this.isLoading,
  });

  @override
  _AppButtonState createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _animationController;

  //Animation curve;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
      lowerBound: 0,
      upperBound: 1 - 315 / 328,
    );

    _animationController.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _animationController.value;
    return GestureDetector(
      onTap: () {
        if (!(widget.isLoading ?? false)) {
          widget.onTap();
        }
      },
      onTapDown: (details) {
        _animationController.forward();
      },
      onTapCancel: () {
        _animationController.reverse();
      },
      onTapUp: (details) {
        _animationController.reverse();
      },
      child: Transform.scale(
        scale: _scale,
        child: buttonBody(),
      ),
    );
  }

  Widget buttonBody() {
    return Container(
      height: widget.height ?? ButtonTheme.of(context).height,
      width: widget.width,

      ///
      decoration: boxDecoration(),
      child: Center(
        child: widget.isLoading ?? false
            ? CircularProgressIndicator(color: Colors.white) : Text(
          widget.title,
          style: widget.titleStyle,
        ),
      ),
    );
  }

  BoxDecoration boxDecoration() {
    return BoxDecoration(
      color: widget.color ?? Theme.of(context).accentColor,
      borderRadius: (widget.borderRadius != null) ? widget.borderRadius : BorderRadius.circular(15),
      boxShadow: widget.boxShadow,

      ///
      gradient: (widget.wGradient == true)
          ? (widget.gradientColors != null)
          ? LinearGradient(
        colors: widget.gradientColors!,
        begin: (widget.beginGradient != null) ? widget.beginGradient! : Alignment.topRight,
        end: (widget.endGradient != null) ? widget.beginGradient! : Alignment.bottomLeft,
      )
          : LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.blue,
          Color(0xff4267B2).withOpacity(.7),
        ],
      )
          : null,

      ///
    );
  }
}
