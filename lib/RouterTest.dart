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
//      initialRoute: "/",
        theme: ThemeData(primarySwatch: Colors.blue),
//      routes: {
//        "new_page": (context) => NewRoute(),
//        "EchoRoute": (context) => EchoRoute(),
//        "RouterTestRoute": (context) => RouterTestRoute(),
//        "tip2": (context) {
//          return TipRoute(
//            text: ModalRoute.of(context).settings.arguments,
//          );
//        },
//        "/": (context) => MyHomePage(
//              title: "flutter demo home page",
//            )
//      },
        home: ScrollControllerTestRoute()
//      Scaffold(
//        appBar: AppBar(
//          title: Text("haha"),
//        ),
//        body: SwitchAndCheckBoxTestRoute(),
//      ),
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

class Echo extends StatelessWidget {
  final String text;
  final Color backgroundColor;

  Echo({Key key, @required this.text, this.backgroundColor: Colors.grey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Container(
        color: backgroundColor,
        child: Text(text),
      ),
    );
  }
}

//TapboxA 管理自身状态

class TapboxA extends StatefulWidget {
  TapboxA({Key key}) : super(key: key);

  @override
  _TapboxAState createState() {
    return _TapboxAState();
  }
}

class _TapboxAState extends State<TapboxA> {
  bool _active = false;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new GestureDetector(
      onTap: _handleTap,
      child: new Container(
        child: new Center(
          child: new Text(
            _active ? "active" : "inactive",
            style: new TextStyle(fontSize: 32, color: Colors.white),
          ),
        ),
        width: 200,
        height: 200,
        decoration: new BoxDecoration(
            color: _active ? Colors.lightGreen[700] : Colors.grey[600]),
      ),
    );
  }
}

//ParentWidget为TapboxB 管理状态
class ParentWidget extends StatefulWidget {
  ParentWidget({Key key}) : super(key: key);

  @override
  _ParentWidgetState createState() {
    return _ParentWidgetState();
  }
}

class _ParentWidgetState extends State<ParentWidget> {
  bool _active = false;

  void _handleTapboxChange(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      child: new TapboxB(
        active: _active,
        onChanged: _handleTapboxChange,
      ),
    );
  }
}

class TapboxB extends StatelessWidget {
  final bool active;
  final ValueChanged<bool> onChanged;

  void _handleTap() {
    onChanged(!active);
  }

  TapboxB({Key key, this.active, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new GestureDetector(
      onTap: _handleTap,
      child: new Container(
        child: new Center(
          child: new Text(
            active ? "Active" : "Inactive",
            style: new TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200,
        height: 200,
        decoration: new BoxDecoration(
            color: active ? Colors.lightGreen[700] : Colors.grey[600]),
      ),
    );
  }
}

class ParentWidgetC extends StatefulWidget {
  ParentWidgetC({Key key}) : super(key: key);

  @override
  _ParentWidgetCState createState() {
    return _ParentWidgetCState();
  }
}

class _ParentWidgetCState extends State<ParentWidgetC> {
  bool _active = false;

  void _handlerTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
        child: new TapboxC(active: _active, onChange: _handlerTapboxChanged));
  }
}

//===========================Tapboxc===============================
class TapboxC extends StatefulWidget {
  final bool active;
  final ValueChanged<bool> onChange;

  TapboxC({Key key, this.active, @required this.onChange}) : super(key: key);

  @override
  _TapboxCState createState() {
    return _TapboxCState();
  }
}

class _TapboxCState extends State<TapboxC> {
  bool _highlight = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTap() {
    widget.onChange(!widget.active);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTap: _handleTap,
      onTapCancel: _handleTapCancel,
      child: new Container(
        child: new Text(
          widget.active ? 'Active' : 'Inactive',
          style: TextStyle(fontSize: 32, color: Colors.white),
        ),
        width: 200,
        height: 200,
        decoration: new BoxDecoration(
            color: widget.active ? Colors.lightGreen[700] : Colors.grey[600],
            border: _highlight
                ? new Border.all(color: Colors.teal[700], width: 10)
                : null),
      ),
    );
  }
}

class CupertinoTestRoute extends StatelessWidget {
  CupertinoTestRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Cupertino Demo"),
      ),
      child: Center(
        child: CupertinoButton(
          color: CupertinoColors.activeBlue,
          child: Text("Press"),
          onPressed: () {},
        ),
      ),
    );
  }
}

//单选开关和复选框
class SwitchAndCheckBoxTestRoute extends StatefulWidget {
  SwitchAndCheckBoxTestRoute({Key key}) : super(key: key);

  @override
  _SwitchAndCheckBoxTestRouteState createState() {
    return _SwitchAndCheckBoxTestRouteState();
  }
}

class _SwitchAndCheckBoxTestRouteState
    extends State<SwitchAndCheckBoxTestRoute> {
  bool _switchSelected = true; //维护单选开关的状态
  bool _checkboxSelected = true; //维护复选框状态
  TextEditingController _unameController = new TextEditingController();

  @override
  void initState() {
    _unameController.addListener(() {
      print("我变化了哦嘿嘿" + _unameController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Switch(
          value: _switchSelected,
          onChanged: (value) {
            //重新构建页面
            setState(() {
              _switchSelected = value;
            });
          },
        ),
        Checkbox(
          value: _checkboxSelected,
          activeColor: Colors.red,
          onChanged: (value) {
            setState(() {
              _checkboxSelected = value;
            });
          },
        ),
        TextField(
          autofocus: true,
          decoration: InputDecoration(
              labelText: "UserName",
              hintText: "UserName or email",
              prefixIcon: Icon(Icons.person)),
          controller: _unameController,
        ),
        TextField(
          decoration: InputDecoration(
              labelText: "password",
              hintText: "your password",
              prefixIcon: Icon(Icons.lock)),
          obscureText: true,
        ),
        RaisedButton(
          child: Text("commit"),
          onPressed: () {
            print(_unameController.text);
          },
        )
      ],
    );
  }
}

//焦点控制
class _FocusTestRouteState extends StatefulWidget {
  _FocusTestRouteState({Key key}) : super(key: key);

  @override
  __FocusTestRouteStateState createState() {
    return __FocusTestRouteStateState();
  }
}

class __FocusTestRouteStateState extends State<_FocusTestRouteState> {
  FocusNode focusNode1 = new FocusNode();
  FocusNode focusNode2 = new FocusNode();
  FocusScopeNode focusScopeNode;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          TextField(
            autofocus: true,
            focusNode: focusNode1,
            decoration: InputDecoration(labelText: "input1"),
          ),
          TextField(
            focusNode: focusNode2,
            decoration: InputDecoration(labelText: "input2"),
          ),
          Builder(builder: (sb) {
            return Column(
              children: <Widget>[
                RaisedButton(
                  child: Text("移动焦点"),
                  onPressed: () {
                    if (focusScopeNode == null) {
                      focusScopeNode = FocusScope.of(context);
                    }
                    focusScopeNode.requestFocus(focusNode2);
                  },
                ),
                RaisedButton(
                  child: Text("隐藏键盘"),
                  onPressed: () {
                    focusNode1.unfocus();
                    focusNode2.unfocus();
                  },
                )
              ],
            );
          })
        ],
      ),
    );
  }
}

class sbflutter extends StatefulWidget {
  sbflutter({Key key}) : super(key: key);

  @override
  _sbflutterState createState() {
    return _sbflutterState();
  }
}

class _sbflutterState extends State<sbflutter> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("shabi"),
      ),
      body: Container(
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              labelText: "email",
              hintText: "电子邮件",
              prefixIcon: Icon(Icons.email),
              border: InputBorder.none),
        ),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: Colors.grey[200], width: 1))),
      ),
//      body: Theme(
//          data: Theme.of(context).copyWith(
//              hintColor: Colors.grey[200],
//              inputDecorationTheme: InputDecorationTheme(
//                  labelStyle: TextStyle(color: Colors.grey),
//                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14.0))),
//          child: Column(
//            children: <Widget>[
//              TextField(
//                decoration: InputDecoration(
//                    labelText: "用户名",
//                    hintText: "用户名或邮箱",
//                    prefixIcon: Icon(Icons.person)),
//              ),
//              TextField(
//                decoration: InputDecoration(
//                    prefixIcon: Icon(Icons.lock),
//                    labelText: "密码",
//                    hintText: "您的登录密码",
//                    hintStyle: TextStyle(color: Colors.grey, fontSize: 13)),
//              )
//            ],
//          )),
    );
  }
}

class FormTestRoute extends StatefulWidget {
  FormTestRoute({Key key}) : super(key: key);

  @override
  _FormTestRouteState createState() {
    return _FormTestRouteState();
  }
}

class _FormTestRouteState extends State<FormTestRoute> {
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  GlobalKey _formkey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Test"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Form(
          key: _formkey,
          autovalidate: true,
          child: Column(
            children: <Widget>[
              TextFormField(
                autofocus: true,
                controller: _usernameController,
                decoration: InputDecoration(
                    labelText: "用户名",
                    hintText: "用户名或邮箱",
                    icon: Icon(Icons.person)),
                validator: (v) {
                  return v.trim().length > 0 ? null : "用户名不能为空";
                },
              ),
              TextFormField(
                controller: _pwdController,
                decoration: InputDecoration(
                    labelText: "密码",
                    hintText: "您的登录密码",
                    icon: Icon(Icons.lock)),
                obscureText: true,
                validator: (v) {
                  return v.trim().length > 5 ? null : "密码不能少于6位";
                },
              ),
              //登录按钮
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Row(
                  children: <Widget>[
                    Expanded(child: Builder(
                      builder: (context) {
                        return RaisedButton(
                          padding: EdgeInsets.all(15),
                          child: Text("登录"),
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          onPressed: () {
                            if ((_formkey.currentState as FormState)
                                .validate()) {
                              print("验证通过");
                            }
                          },
                        );
                      },
                    ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FlexLayoutTestRoute extends StatelessWidget {
  FlexLayoutTestRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            Expanded(flex: 1, child: Container(height: 30, color: Colors.red)),
            Expanded(
              flex: 2,
              child: Container(
                height: 30,
                color: Colors.green,
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: SizedBox(
            height: 100,
            child: Flex(
              direction: Axis.vertical,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 30,
                    color: Colors.red,
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                Expanded(
                    flex: 1, child: Container(height: 30, color: Colors.green))
              ],
            ),
          ),
        )
      ],
    );
  }
}

class WrapRoute extends StatelessWidget {
  WrapRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("hahh"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              alignment: WrapAlignment.center,
              children: <Widget>[
                new Chip(
                  label: new Text("Hamilton"),
                  avatar: new CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text("A"),
                  ),
                ),
                new Chip(
                  label: new Text("Lafayette"),
                  avatar: new CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text("M"),
                  ),
                ),
                new Chip(
                  label: new Text("Muligan"),
                  avatar: new CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text("H"),
                  ),
                ),
                new Chip(
                  avatar: new CircleAvatar(
                      backgroundColor: Colors.blue, child: Text("J")),
                  label: new Text("Laurens"),
                )
              ],
            ),
            Flow(
              delegate: TestFlowDelegate(EdgeInsets.all(10)),
              children: <Widget>[
                new Container(
                  width: 80,
                  height: 80,
                  color: Colors.red,
                ),
                new Container(
                  width: 80,
                  height: 80,
                  color: Colors.green,
                ),
                new Container(
                  width: 80,
                  height: 80,
                  color: Colors.blue,
                ),
                new Container(
                  width: 80,
                  height: 80,
                  color: Colors.yellow,
                ),
                new Container(
                  width: 80,
                  height: 80,
                  color: Colors.brown,
                ),
                new Container(
                  width: 80,
                  height: 80,
                  color: Colors.purple,
                ),
              ],
            ),
//            PaddingTestRoute(),
//            ConstrainedBoxRoute(),
//            DecoratedBox(
//              decoration: BoxDecoration(
//                  gradient:
//                      LinearGradient(colors: [Colors.red, Colors.orange[700]]),
//                  borderRadius: BorderRadius.circular(3),
//                  boxShadow: [
//                    BoxShadow(
//                        color: Colors.black54,
//                        offset: Offset(2, 2),
//                        blurRadius: 4)
//                  ]),
//              child: Padding(
//                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 18),
//                child: Text(
//                  "Login",
//                  style: TextStyle(color: Colors.white),
//                ),
//              ),
////
            Container(
              margin: EdgeInsets.all(20),
              color: Colors.orange,
              child: Text("hello world"),
            ),
            Container(
              padding: EdgeInsets.all(20),
              color: Colors.orange,
              child: Text("hello world"),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.orange),
                child: Text("hello world"),
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.orange),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text("Hello world"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TestFlowDelegate extends FlowDelegate {
  EdgeInsets margin = EdgeInsets.zero;

  TestFlowDelegate(this.margin);

  @override
  void paintChildren(FlowPaintingContext context) {
    // TODO: implement paintChildren
    var x = margin.left;
    var y = margin.top;
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i).width + x + margin.right;
      if (w < context.size.width) {
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0));
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i).height + margin.top + margin.bottom;
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0));
        x += context.getChildSize(i).width + margin.left + margin.right;
      }
    }
  }

  @override
  Size getSize(BoxConstraints constraints) {
    // TODO: implement getSize
    return Size(double.infinity, 200);
  }

  @override
  bool shouldRepaint(FlowDelegate delegate) {
    {
      // TODO: implement shouldRepaint
      return delegate != this;
    }
  }
}

class ConstrainedRoute extends StatelessWidget {
  ConstrainedRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("hehe"),
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: <Widget>[
            Positioned(
              child: Text("I am jack"),
              left: 18,
            ),
            Container(
              child: Text(
                "hello world",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.red,
            ),
            Positioned(
              top: 18,
              child: Text("your friend"),
            )
          ],
        ),
      ),
    );
  }
}

class PaddingTestRoute extends StatelessWidget {
  PaddingTestRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text("hello world"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text("i am jack"),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Text("Your friend"),
          ),
        ],
      ),
    );
  }
}

//==================ConstrainedBox=====================
class ConstrainedBoxRoute extends StatelessWidget {
  ConstrainedBoxRoute({Key key}) : super(key: key);
  Widget redBox = DecoratedBox(
    decoration: BoxDecoration(color: Colors.red),
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: double.infinity,
        minHeight: 10,
      ),
      child: Container(
        height: 5,
        child: redBox,
      ),
    );
  }
}
//==================SingleChildScrollViewTestRoute============

class SingleChildScrollViewTestRoute extends StatelessWidget {
  String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

  SingleChildScrollViewTestRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scrollbar(
        child: Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: str
                .split("")
                .map((e) => Text(
                      e,
                      textScaleFactor: 2.0,
                    ))
                .toList(),
          ),
        ),
      ),
    ));
  }
}

class ListViewRoute extends StatelessWidget {
  ListViewRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: ListView.builder(
      itemCount: 100,
      itemExtent: 50,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text("$index"),
        );
      },
    ));
  }
}

class ListView3 extends StatelessWidget {
  ListView3({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Widget divider1 = Divider(
      color: Colors.blue,
    );
    Widget divider2 = Divider(color: Colors.green);
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text("$index"),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return index % 2 == 0 ? divider1 : divider2;
        },
        itemCount: 100);
  }
}

class InfiniteListView extends StatefulWidget {
  InfiniteListView({Key key}) : super(key: key);

  @override
  _InfiniteListViewState createState() {
    return _InfiniteListViewState();
  }
}

class _InfiniteListViewState extends State<InfiniteListView> {
  static const loadingTag = "loading"; //尾部标记
  var _words = <String>[loadingTag];

  @override
  void initState() {
    _retrieveData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.separated(
        itemBuilder: (context, index) {
          if (_words[index] == loadingTag) {
            if (_words.length - 1 < 100) {
              _retrieveData();
              return Container(
                padding: const EdgeInsets.all(16),
                alignment: Alignment.center,
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ),
              );
            } else {
              return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(16),
                child: Text(
                  "没有更多了",
                  style: TextStyle(color: Colors.grey),
                ),
              );
            }
          }
          return ListTile(
            title: Text(_words[index]),
          );
        },
        separatorBuilder: (context, index) => Divider(
              height: .0,
            ),
        itemCount: _words.length);
  }

  void _retrieveData() {
    Future.delayed(Duration(seconds: 2)).then((value) {
      _words.insertAll(_words.length - 1,
          generateWordPairs().take(30).map((e) => e.asPascalCase).toList());
      setState(() {});
    });
  }
}

class ListView4 extends StatelessWidget {
  ListView4({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        ListTile(
          title: Text("商品列表"),
        ),
        Expanded(
          child:
              ListView.builder(itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text("$index"),
            );
          }),
        )
      ],
    );
  }
}

class GridView1 extends StatelessWidget {
  GridView1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: 1),
      children: <Widget>[
        Icon(Icons.ac_unit),
        Icon(Icons.airport_shuttle),
        Icon(Icons.all_inclusive),
        Icon(Icons.beach_access),
        Icon(Icons.cake),
        Icon(Icons.free_breakfast)
      ],
    );
  }
}

class InfiniteGridView extends StatefulWidget {
  InfiniteGridView({Key key}) : super(key: key);

  @override
  _InfiniteGridViewState createState() {
    return _InfiniteGridViewState();
  }
}

class _InfiniteGridViewState extends State<InfiniteGridView> {
  List<IconData> _icons = []; //保存icon数据
  @override
  void initState() {
    _retrieveIcons();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: 1),
      itemCount: _icons.length,
      itemBuilder: (context, index) {
        if (index == _icons.length - 1 && _icons.length < 200) {
          _retrieveIcons();
        }
        return Icon(_icons[index]);
      },
    );
  }

  void _retrieveIcons() {
    Future.delayed(Duration(microseconds: 200)).then((value) {
      setState(() {
        _icons.addAll([
          Icons.ac_unit,
          Icons.airport_shuttle,
          Icons.all_inclusive,
          Icons.beach_access,
          Icons.cake,
          Icons.free_breakfast
        ]);
      });
    });
  }
}

class CustomScrollViewTestRoute extends StatelessWidget {
  CustomScrollViewTestRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text("Demo"),
              background: Image.asset(
                "images/img.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8),
            sliver: new SliverGrid(
                delegate: new SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return new Container(
                    alignment: Alignment.center,
                    color: Colors.cyan[100 * (index % 9)],
                    child: new Text("grid item $index"),
                  );
                }, childCount: 20),
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 4)),
          ),
          new SliverFixedExtentList(
              delegate: new SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return new Container(
                  alignment: Alignment.center,
                  color: Colors.lightGreen[100 * (index % 9)],
                  child: new Text("list item $index"),
                );
              }, childCount: 50),
              itemExtent: 50)
        ],
      ),
    );
  }
}

class ScrollControllerTestRoute extends StatefulWidget {
  ScrollControllerTestRoute({Key key}) : super(key: key);

  @override
  _ScrollControllerTestRouteState createState() {
    return _ScrollControllerTestRouteState();
  }
}

class _ScrollControllerTestRouteState extends State<ScrollControllerTestRoute> {
  ScrollController _controller = new ScrollController();
  bool showToTopBtn = false;

  @override
  void initState() {
    _controller.addListener(() {
      print(_controller.offset);
      if (_controller.offset < 1000 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (_controller.offset >= 1000 && showToTopBtn == false) {
        setState(() {
          showToTopBtn = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("滚动控制"),
      ),
      body: Scrollbar(
        child: ListView.builder(
            itemCount: 100,
            itemExtent: 50,
            controller: _controller,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text("$index"),
              );
            }),
      ),
      floatingActionButton: !showToTopBtn
          ? null
          : FloatingActionButton(
              child: Icon(Icons.arrow_upward),
              onPressed: () {
                _controller.animateTo(.0,
                    duration: Duration(milliseconds: 200), curve: Curves.ease);
              },
            ),
    );
  }
}
