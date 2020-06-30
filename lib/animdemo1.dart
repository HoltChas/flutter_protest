import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  double _height = 200;
  bool _big = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter动画 Demo1"),
      ),
      body: Center(
        child: Container(
            width: 300,
            height: 120,
            color: Colors.blue,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: AnimatedCounter(value: 1),
                ),
                Expanded(
                  child: AnimatedCounter(value: 1),
                ),
                Expanded(
                  child: AnimatedCounter(value: 2),
                )
              ],
            )),
      ),

      /** 万能的补间动画 */
//      Center(
//        child: TweenAnimationBuilder(
//          duration: Duration(seconds: 1),
//          tween: Tween<double>(
//              begin: 72.0,
//              end: _big ? 172.0 : 72.0), //在duration2s内帮你（按照动画效果，默认是线性）补充0.0-1.0之间的数字, 注意：动画是从现在的值，变动到end的值
//          curve: Curves.linear,
//          builder: (BuildContext context, value, Widget child) {
//            return Container(
//              width: 250,
//              height: 250,
//              color: Colors.blue,
//              child: Center(
//                  child: Text(
//                "Hi",
//                style: TextStyle(fontSize: value),
//              )),
//            );
//          },
//        ),
//      ),
      /** Animated 控件curve动画效果 */
//      AnimatedPadding(
//        duration: Duration(seconds: 2),
//        padding: EdgeInsets.only(top: _height),
//        curve: Curves.bounceOut,
//        child: Container(
//          width: 300,
//          height: 300,
//          color: Colors.blue,
//        ),
//      ),
      /** Animated控件动画 */
//      Center(
//        child: AnimatedContainer(
//          duration: Duration(seconds: 1),
//          width: 300,
//          height: _height,
////          decoration: BoxDecoration(
////            gradient: LinearGradient(
////              begin: Alignment.bottomCenter,
////              end: Alignment.topCenter,
////              stops: [0.2, 0.3],
////              colors: [Colors.orange, Colors.white]
////            ),
////            boxShadow:[
////              BoxShadow(spreadRadius: 25, blurRadius: 25)
////            ],
////            borderRadius: BorderRadius.circular(150),
////          ),
//          color: Colors.orange,
//          child: AnimatedSwitcher(
//              duration: Duration(seconds: 2),
////              child: Center(child: CircularProgressIndicator())
////            child: Image.network("http://pic1.sc.chinaz.com/files/pic/pic9/202006/apic25949.jpg"),
//              child: Text("Good",
//                  key: UniqueKey(), style: TextStyle(fontSize: 24)),
//              transitionBuilder: (child, animation) {
//                return FadeTransition(
//                    opacity: animation,
//                    child: ScaleTransition(
//                      scale: animation,
//                      child: child,
//                    ));
//              }),
////
////          child: Center(
////              child: Text("Welcome", style: TextStyle(fontSize: 24))),
//        ),
//      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
//        onPressed: () {
//          setState(() {
////            _height = _height + 100;
////            if (_height > 500) _height = 200;
//            _big = !_big;
//          });
//        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class AnimatedCounter extends StatelessWidget {
  Duration duration;
  final int value;

  AnimatedCounter(
      {@required this.value, this.duration = const Duration(seconds: 1)});

  @override
  Widget build(BuildContext context) {
    return /** 翻转的计数器 */
        TweenAnimationBuilder(
      duration: duration,
      tween: Tween(end: value.toDouble()),
      builder: (BuildContext context, value, Widget child) {
        final whole = value ~/ 1;
        final decimal = value - whole;
        print("$whole + $decimal");
        return Stack(children: [
          Positioned(
            top: -100 * decimal, // 0 -> -100
            child: Opacity(
              opacity: 1.0 - decimal, //1->0.0
              child: Text(
                "$whole",
                style: TextStyle(fontSize: 70),
              ),
            ),
          ),
          Positioned(
            top: 100 - decimal * 100, //100 -> 0
            child: Opacity(
              opacity: decimal, //0.0 -> 1
              child: Text(
                "${whole + 1}",
                style: TextStyle(fontSize: 70),
              ),
            ),
          ),
        ]);
      },
    );
  }
}
