import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insu_web/core/constants/constants.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: EdgeInsets.all(50),
      decoration: BoxDecoration(
        color: Colors.grey,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 250,
                child: SvgPicture.asset('assets/icons/profile.svg'),
              ),
              const SizedBox(width: 30),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'user.name@mail.com',
                    style: AppTextStyles.pageText.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Password: ********',
                    style: AppTextStyles.pageText.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
          Text(
            'Balance: 600\$',
            style: AppTextStyles.pageText.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
