import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:insu_web/config.dart';
import 'package:insu_web/core/constants/constants.dart';
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
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30, bottom: 30),
              child: Row(
                children: [
                  Container(
                    height: 500,
                    width: (MediaQuery.of(context).size.width - AppConfig.panelCollapsedWidth - 90) / 2,
                    padding: EdgeInsets.all(50),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                    ),
                  ),
                  const SizedBox(width: 30),
                  Container(
                    height: 500,
                    width: (MediaQuery.of(context).size.width - AppConfig.panelCollapsedWidth - 90) / 2,
                    padding: EdgeInsets.all(50),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'My wallet address',
                          style: AppTextStyles.pageText.copyWith(color: Colors.white),
                        ),
                        const SizedBox(height: 50),
                        Container(
                          width: double.infinity,
                          height: 50,
                          margin: EdgeInsets.only(left: 50, right: 50),
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () {
                                    Clipboard.setData(new ClipboardData(text: "Ты ебнтй"));
                                    print('kall');
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(5),
                                    decoration: BoxDecoration(color: Colors.grey),
                                    width: 80,
                                    height: double.infinity,
                                    alignment: Alignment.center,
                                    child: Text(
                                      'COPY',
                                      style: AppTextStyles.pageText.copyWith(color: Colors.black, fontSize: 25),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
