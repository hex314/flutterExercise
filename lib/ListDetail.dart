import 'package:flutter/material.dart';

class ListDetail extends StatefulWidget{
  @override
  createState() =>new ListDetailState();
  
  }
  
  class ListDetailState extends State<ListDetail>{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        titleSpacing: 0,
        centerTitle: false,
        title: Text('收件箱'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.sort_by_alpha), onPressed: () {},),
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {},)
        ],
      ),
      body: new ListView(
        children: <Widget>[
          Text('1'),
          Text('2'),
          Text('3')
        ],
      )
    );
  }
}