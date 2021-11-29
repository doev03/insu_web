import 'package:flutter/material.dart';
import 'package:insu_web/core/constants/colors.dart';
import 'package:insu_web/utils/side_panel.dart';

import '../../config.dart';
import 'widgets/home_button.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  final sidePanelKey = GlobalKey<SidePanelState>();

  @override
  Widget build(BuildContext context) {
    return ExamplePage();
  }
}

class ExamplePage extends StatefulWidget {
  const ExamplePage({Key? key}) : super(key: key);

  @override
  _ExamplePageState createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> with TickerProviderStateMixin {
  bool isPressed = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final button = HomeButton(
      color: Colors.black,
      onTap: () {
        isPressed = !isPressed;
      },
      page: CollapsablePage(),
    );

    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: AppConfig.panelCollapsedWidth),
      child: GridView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 100, vertical: 100),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20, mainAxisExtent: 200, childAspectRatio: 1),
        children: [button, button, button, button],
      ),
    );
  }
}

class CollapsablePage extends StatelessWidget {
  const CollapsablePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 100, vertical: 50),
        child: Column(
          children: [
            Text(
              'Илья Горюнов семь лет отсидел в тюрьме по ложному обвинению в распространении наркотиков. Теперь он выходит на свободу движимый лишь одним желанием — отомстить тому мажору Петру, который подбросил ему наркотики и поломал жизнь. Встретившись лицом к лицу со своим обидчиком, Илья совершает импульсивный поступок и получает доступ к смартфону Петра, а с ним и к жизни молодого человека — его фотографиям и видео, перепискам с родителями и девушкой Ниной, к странным, полным недомолвок и угроз переговорам с коллегами. На время Илья становится для всех Петром — через текст на экране телефона. Илья Горюнов семь лет отсидел в тюрьме по ложному обвинению в распространении наркотиков. Теперь он выходит на свободу движимый лишь одним желанием — отомстить тому мажору Петру, который подбросил ему наркотики и поломал жизнь. Встретившись лицом к лицу со своим обидчиком, Илья совершает импульсивный поступок и получает доступ к смартфону Петра, а с ним и к жизни молодого человека — его фотографиям и видео, перепискам с родителями и девушкой Ниной, к странным, полным недомолвок и угроз переговорам с коллегами. На время Илья становится для всех Петром — через текст на экране телефона.',
              style: TextStyle(color: Colors.white, fontSize: 50),
            ),
            Icon(Icons.animation, color: Colors.white, size: 100,),
          ],
        ),
      ),
    );
  }
}

class PageOpeningPainter extends CustomPainter {
  final Color color;
  final double progress;
  final double targetWidth;
  final double targetHeight;

  PageOpeningPainter({this.color = Colors.blue, required this.progress, required this.targetWidth, required this.targetHeight});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
          Rect.fromCenter(center: Offset(size.width / 2, size.height / 2), width: targetWidth * progress + size.width / 2, height: targetHeight * progress + size.height / 2),
          Radius.circular(25)),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
