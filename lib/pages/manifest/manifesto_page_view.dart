import 'package:flutter/material.dart';
import 'package:insu_web/core/constants/colors.dart';
import 'package:insu_web/core/constants/constants.dart';

class ManifestoPageView extends StatefulWidget {
  const ManifestoPageView({Key? key}) : super(key: key);

  @override
  _ManifestoPageViewState createState() => _ManifestoPageViewState();
}

class _ManifestoPageViewState extends State<ManifestoPageView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: AppColors.pageBackground,
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.27, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'MANIFESTO',
              style: AppTextStyles.header,
            ),
            Text(
              '\n\n   The main goal of the fund is to adapt existing fiat financial '
              'institutions to decentralized finance. Cryptocurrency is '
              'currently used for a wide range of purposes, but only a few '
              'projects are ready to take on the responsibility and role of '
              'servicing and adapting financial institutions. Insurance, banks, '
              'lending - all these mechanisms are an integral part of the life '
              'of every person in the modern world.'
              ''
              '\n\n   Cryptocurrency, as the experience of 2018 showed, is not '
              'enough to be just decentralized or just grow in value. High '
              'market volatility has two sides of the coin: a participant can '
              'not only be awarded a high interest rate and quick xx, but also '
              'receive a feedback and liquidation of their deposits. To stabilize '
              'volatility, we use the technology of insuring financial risks, '
              'using the fund\'s resources distributed among users, who in turn '
              'are the insurance company. Our goal is only service, '
              'identification of problems and optimization of risk insurance '
              'mechanisms.'
              ''
              '\n\n   Graduation is a top priority goal. Most market participants '
              'want to have long-term prospects for their investments, but '
              'not everyone can put aside their enthusiasm and assess the '
              'overall situation with a cool head in the long term. A good '
              'indicator of this is the unnecessarily bloated NFT market and '
              'countless GameFi projects. We offer an alternative view. '
              'Insurance reporting and detailed charts of fund participants\' '
              'activity in recruiting a critical mass of users will be new '
              'fundamental indicators that provide an opportunity to look at '
              'the financial decisions of players in the long term.'
              ''
              '\n\n   In conclusion, it is important to note that our team is not an '
              'insurance company, we only create and maintain a decentralized '
              'financial institution, in different shares owned by each member '
              'of the fund. Our motto is: "In order to earn, let others earn."',
              style: AppTextStyles.pageText,
            )
          ],
        ),
      ),
    );
  }
}
