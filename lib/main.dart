import 'package:flutter/material.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'dart:convert';
import 'package:dio/dio.dart';

void main() => runApp(new MyApp());

splitHtmlBodyToJson(String h) {
  List aaa = h.split('<body>');
  List bbb = aaa[1].toString().split('</body>');
  String ccc = bbb[0].toString().trim();
  return jsonDecode(ccc);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false, title: 'wwww', home: new SHome());
  }
}

class SHome extends StatefulWidget {
  @override
  createState() => new SHomeState();
}

class SHomeState extends State<SHome> {
  @override
  void initState() {
    super.initState();
    getHttp();
  }
  final String str11 = 'RomilaHe';
  Response res;
  void getHttp() async {
    Response rest;
    try {
      rest = await Dio().get("http://192.168.9.204/a.html");
      // debugPrint(res.data.toString());
      print(rest);
    } catch (e) {
      return print(e);
    }
    setState(() {
      res=rest;
    });
  }

  getIcon(int i) {
    if (i == 1) {
      return Icon(Icons.inbox, size: 32.0, color: Colors.blue[300]);
    } else if (i == 2) {
      return Icon(Icons.all_inclusive, size: 30.0, color: Colors.red[200]);
    } else if (i == 3) {
      return Icon(Icons.list, size: 28.0, color: Colors.grey);
    } else {
      return Icon(Icons.add, size: 28.0, color: Colors.grey);
    }
  }

  _mylist() {
    List decoded = splitHtmlBodyToJson(res.data.toString());
    List<Widget> widgets = [];
    for (int i = 0; i < decoded.length; i++) {
      widgets.add(
        new Padding(
            padding: new EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: i >= 1
                      ? Divider(height: 1.0,)
                      : Container(
                          height: 0.0,
                        ),
                ),
                InkWell(
                  child: new Padding(
                    padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: new Row(
                    children: <Widget>[
                      Expanded(
                        child: IconButton(
                          icon: getIcon(decoded[i]['type']),
                          onPressed: () {},
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Text(decoded[i]['listname'],
                            style: TextStyle(fontSize: 20.0)),
                        flex: 6,
                      ),
                      Expanded(
                        child: Text(decoded[i]['num'].toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey)),
                        flex: 1,
                      ),
                    ],
                  ),
                  ) ,onTap:(){
                    print(i);
                  },
                ),
              ],
            )),
      ); // new Text( " ${decoded[i]['listname']} Num ${decoded[i]['num']} "),));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    var userAvartar = Container(
      margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: CircularProfileAvatar(
        radius: 100,
        backgroundColor: Colors.purple,
        borderWidth: 0,
        initialsText: Text(
          str11.substring(0, 1),
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        borderColor: Colors.brown,
        elevation: 0.0,
        foregroundColor: Colors.purple[400],
        cacheImage: true,
        onTap: () {
          print('avatar is pressed');
        },
        showInitialTextAbovePicture: true,
        imageUrl: 'https://static.haha.mx/images/topic_default.png',
      ),
      width: 10.0,
      height: 10.0,
      //   IconButton(
      //   icon: Icon(
      //     Icons.menu,
      //     size: 32,
      //     color: Colors.white,
      //   ),
      //   onPressed: () => debugPrint('menu pressed'),
      // ),
    );
    return new Scaffold(
      appBar: new AppBar(
        leading: userAvartar,
        title: Text(str11),
        titleSpacing: 0.0,
        centerTitle: false,
        backgroundColor: Colors.teal[800],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications_none, size: 28, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon:
                Icon(Icons.chat_bubble_outline, size: 28, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.search,
              size: 28,
              color: Colors.white,
            ),  
            onPressed: () => debugPrint('scan pressed'),
          ),
        ],
      ),
      body: res!=null ?  new ListView(children: _mylist(),) : new Text("loading")
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  Widget buildTextField() {
    return Theme(
      data: new ThemeData(primaryColor: Colors.grey),
      child: new TextField(
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
          border: InputBorder.none,
          icon: Icon(Icons.search),
          hintText: "搜索电影",
          hintStyle: new TextStyle(
            fontSize: 14,
            color: Color.fromARGB(50, 0, 0, 0),
          ),
        ),
        style: new TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Container(
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
        ),
        alignment: Alignment.centerLeft,
        height: 36,
        padding: EdgeInsets.fromLTRB(10.0, 0, 0.0, 0),
        child: buildTextField(),
      );
}
