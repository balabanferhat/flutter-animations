import 'dart:math';

import 'package:animations_example/page/animated_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ThirdPage extends StatefulWidget {
  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> with TickerProviderStateMixin {
  Animation _arrowAnimation, _heartAnimation;
  AnimationController _arrowAnimationController, _heartAnimationController;

  @override
  void initState() {
    super.initState();
    _arrowAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _arrowAnimation =
        Tween(begin: 0.0, end: pi).animate(_arrowAnimationController);

    _heartAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1200));
    _heartAnimation = Tween(begin: 150.0, end: 170.0).animate(CurvedAnimation(
        curve: Curves.bounceOut, parent: _heartAnimationController));

    _heartAnimationController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _heartAnimationController.repeat();
      }
    });

    _editingController = TextEditingController(text: initialText);
  }

  @override
  void dispose() {
    _editingController.dispose();
    _arrowAnimationController?.dispose();
    _heartAnimationController?.dispose();
    super.dispose();
  }

  Widget _editTitleTextField() {
    if (_isEditingText)
      return Center(
        child: TextField(
          onSubmitted: (newValue) {
            setState(() {
              initialText = newValue;
              _isEditingText = false;
            });
          },
          autofocus: true,
          controller: _editingController,
        ),
      );
    return InkWell(
        onTap: () {
          setState(() {
            _isEditingText = true;
          });
        },
        child: Text(
          initialText,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        ));
  }

  bool _isEditingText = false;
  TextEditingController _editingController;
  String initialText = "Initial Text";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          firstChild(),
          SizedBox(
            height: 20.0,
          ),
          secondChild(),
          SizedBox(
            height: 20.0,
          ),
          OutlineButton(
            color: Colors.white,
            textColor: Colors.black,
            padding: const EdgeInsets.all(12.0),
            child: Text('Start Container Animation'),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AnimatedScreen()));
            },
            splashColor: Colors.red,
          ),
          SizedBox(
            height: 20.0,
          ),
          //_editTitleTextField(),
          /*TextField(
            controller: _editingController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'User Name',
            ),
            onChanged: (text) {
              setState(() {
                //UserName = text;
                //you can access nameController in its scope to get
                // the value of text entered as shown below
                //UserName = nameController.text;
              });
            },
          )*/
        ],
      ),
    );
  }

  Widget firstChild() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        AnimatedBuilder(
          animation: _arrowAnimationController,
          builder: (context, child) => Transform.rotate(
            angle: _arrowAnimation.value,
            child: Icon(
              Icons.expand_more,
              size: 50.0,
              color: Colors.black,
            ),
          ),
          //  child:
        ),
        OutlineButton(
          color: Colors.white,
          textColor: Colors.black,
          padding: const EdgeInsets.all(12.0),
          child: Text('Start Icon Animation'),
          onPressed: () {
            _arrowAnimationController.isCompleted
                ? _arrowAnimationController.reverse()
                : _arrowAnimationController.forward();
          },
          splashColor: Colors.red,
        )
      ],
    );
  }

  Widget secondChild() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Expanded(
          child: AnimatedBuilder(
            animation: _heartAnimationController,
            builder: (context, child) {
              return Center(
                child: Container(
                  child: Center(
                    child: Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: _heartAnimation.value,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: OutlineButton(
              padding: const EdgeInsets.all(12.0),
              color: Colors.white,
              textColor: Colors.black,
              child: Text('Start Beating Heart Animation'),
              onPressed: () {
                _heartAnimationController.forward();
              },
              splashColor: Colors.red,
            ),
          ),
        )
      ],
    );
  }
}
