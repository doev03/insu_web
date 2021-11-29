import 'dart:io';

import 'package:flutter/material.dart';
import 'package:insu_web/core/constants/constants.dart';
import 'package:insu_web/utils/app_button.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportForm extends StatefulWidget {
  const SupportForm({Key? key}) : super(key: key);

  @override
  _SupportFormState createState() => _SupportFormState();
}

class _SupportFormState extends State<SupportForm> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final messageController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Contact e-mail', style: AppTextStyles.pageText),
            const SizedBox(height: 10),
            TextFormField(
              controller: emailController,
              style: AppTextStyles.pageText.copyWith(fontSize: 30),
              decoration: InputDecoration(border: OutlineInputBorder(), errorStyle: TextStyle(fontSize: 30, fontFamily: 'MatthanSans')),
              validator: (value) {
                Pattern pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regex = new RegExp(pattern.toString());
                if (value != null && !regex.hasMatch(value))
                  return 'Enter a valid email';
                else
                  return null;
              },
            ),
            const SizedBox(height: 50),
            Text('Please provide details about the issue you are having', style: AppTextStyles.pageText),
            const SizedBox(height: 10),
            TextFormField(
              controller: messageController,
              maxLines: 10,
              style: AppTextStyles.pageText.copyWith(fontSize: 30),
              decoration: InputDecoration(border: OutlineInputBorder(), errorStyle: TextStyle(fontSize: 30, fontFamily: 'MatthanSans')),
              validator: (value) {
                if (value != null && value.length < 10) {
                  return 'The message must contain at least 10 characters';
                }
              },
            ),
            const SizedBox(height: 50),
            AppButton(
              width: 250,
              height: 70,
              title: 'Send',
              titleStyle: AppTextStyles.pageText.copyWith(color: AppColors.pageBackground),
              color: Colors.white,
              onTap: () async {
                formKey.currentState!.validate();
                final mailTo = Mailto(
                  to: ['doev03@gmail.com'],
                  subject: 'Insu Support',
                  body: '${messageController.text}\n\nBy ${emailController.text}',
                );

                final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 3000);
                await for (HttpRequest request in server) {
                  print('received request!');
                  request.response
                    ..statusCode = HttpStatus.ok
                    ..headers.contentType = ContentType.html
                    ..write(renderHtml(mailTo));
                  await request.response.close();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

String renderHtml(Mailto mailTo) => '''
<html>
  <head>
    <title>mailto example</title>
  </head>
  <body>
    <a href="$mailTo">Open mail client</a>
  </body>
</html>
''';