import 'package:flutter/material.dart';
import 'package:insu_web/config.dart';
import 'package:insu_web/core/constants/colors.dart';
import 'package:insu_web/pages/contacts/widgets/support_form.dart';

class ContactsPageView extends StatefulWidget {
  const ContactsPageView({Key? key}) : super(key: key);

  @override
  _ContactsPageViewState createState() => _ContactsPageViewState();
}

class _ContactsPageViewState extends State<ContactsPageView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.pageBackground,
      padding: EdgeInsets.only(left: AppConfig.panelCollapsedWidth),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.25, vertical: 50),
          child: SupportForm(),
        ),
      ),
    );
  }
}
