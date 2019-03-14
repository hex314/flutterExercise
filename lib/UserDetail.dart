import 'package:flutter/material.dart';

class UserDetail extends StatefulWidget {
  @override
  createState() => new UserDetailState();
}

class UserDetailState extends State<UserDetail> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          titleSpacing: 0,
          centerTitle: false,
          title: Text('账户详情'),
        ),
        body: new ListView(
          children: <Widget>[Text('1'), Text('2'), Text('3')],
        ));
  }
}
