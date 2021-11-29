import 'package:flutter/material.dart';
import 'package:insu_web/config.dart';
import 'package:insu_web/core/constants/colors.dart';
import 'package:insu_web/pages/profile/widgets/profile_card.dart';

class ProfilePageView extends StatefulWidget {
  const ProfilePageView({Key? key}) : super(key: key);

  @override
  _ProfilePageViewState createState() => _ProfilePageViewState();
}

class _ProfilePageViewState extends State<ProfilePageView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: AppConfig.panelCollapsedWidth),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(30),
              child: ProfileCard(),
            ),
          ],
        ),
      ),
    );
  }
}
