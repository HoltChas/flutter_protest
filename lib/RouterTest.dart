import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: "/",
      theme: ThemeData(primarySwatch: Colors.blue),
      routes: {
        "new_page": (context) => NewRoute(),
        "EchoRoute": (context) => EchoRoute(),
        "RouterTestRoute": (context) => RouterTestRoute(),
        "tip2": (context) {
          return TipRoute(
            text: ModalRoute.of(context).settings.arguments,
          );
        },
        "/": (context) => MyHomePage(
              title: "flutter demo home page",
            )
      },
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

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("You have pushed the button this many times"),
            new Text(
              "$_counter",
              style: Theme.of(context).textTheme.headline4,
            ),
            FlatButton(
              child: Text("open new route"),
              textColor: Colors.blue,
              onPressed: () {
                Navigator.of(context)
                    .pushNamed("EchoRoute", arguments: "hihih");
              },
            ),
            RandomWordsWidget(),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'increment',
        child: new Icon(Icons.add),
      ),
    );
  }
}

class NewRoute extends StatelessWidget {
  NewRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("New Route"),
      ),
      body: Center(
        child: Text("This is new route"),
      ),
    );
  }
}

class TipRoute extends StatelessWidget {
  final String text;

  TipRoute({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("提示"),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(text),
              RaisedButton(
                onPressed: () => Navigator.pop(context, "我是返回值"),
                child: Text("返回"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RouterTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("跳转得到返回值"),
      ),
      body: Center(
        child: RaisedButton(
          child: RaisedButton(
            textColor: Colors.yellow,
            onPressed: () async {
              var result = await Navigator.pushNamed(context, "tip2",
                  arguments: "caocaocao");
              print("路由返回值$result");
            },
            child: Text("打开提示页"),
          ),
        ),
      ),
    );
  }
}

class EchoRoute extends StatelessWidget {
  EchoRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("EchoRoute"),
      ),
      body: Center(
        child: Text("This is EchoRoutee ------------$args"),
      ),
    );
  }
}

class RandomWordsWidget extends StatelessWidget {
  RandomWordsWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final wordPair = new WordPair.random();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Text(wordPair.toString()),
    );
  }
}
