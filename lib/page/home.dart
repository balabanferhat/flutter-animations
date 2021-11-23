import 'package:animations/animations.dart';
import 'package:animations_example/main_old.dart';
import 'package:animations_example/page/second_page.dart';
import 'package:animations_example/page/third_screen.dart';
import 'package:flutter/material.dart';

import 'first_page.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isFirstPage = true;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(MyApp.title)),
        body: Column(
          children: <Widget>[
            Expanded(child: buildCards()),
            buildButtons(),
          ],
        ),
      );

  Widget buildCards() => PageTransitionSwitcher(
        duration: Duration(milliseconds: 3000),
        reverse: isFirstPage,
        transitionBuilder: (child, animation, secondaryAnimation) =>
            SharedAxisTransition(
          child: child,
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.horizontal,
        ),
        child: isFirstPage ? FirstPage() : ThirdPage(),
      );

  Widget buildButtons() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TextButton(
              onPressed: isFirstPage ? null : togglePage,
              child: Text('BACK'),
            ),
            ElevatedButton(
              onPressed: isFirstPage ? togglePage : null,
              child: Text('NEXT'),
            ),
          ],
        ),
      );

  void togglePage() => setState(() => isFirstPage = !isFirstPage);
}
