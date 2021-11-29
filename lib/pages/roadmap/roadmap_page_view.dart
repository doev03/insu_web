import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insu_web/config.dart';
import 'package:insu_web/core/constants/colors.dart';

class RoadmapPageView extends StatefulWidget {
  const RoadmapPageView({Key? key}) : super(key: key);

  @override
  _RoadmapPageViewState createState() => _RoadmapPageViewState();
}

class _RoadmapPageViewState extends State<RoadmapPageView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.pageBackground,
      padding: EdgeInsets.only(left: AppConfig.panelCollapsedWidth),
      child: Center(
        child: SvgPicture.asset('assets/icons/roadmap.svg')
      ),
    );
  }
}
