import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'newAvatar.dart';

class AvatarPage extends StatefulWidget {
  @override
  createState() => new AvatarPageState();
}

class AvatarPageState extends State<AvatarPage> {
  bool ckvalue = true;
  Response res;
  Map bl = {'星标任务': '将星标任务移到顶部', '推迟提醒': '5分', '添加任务': '清单底部'};

  get check => null;
  void getHttp() async {
    Response rest;
    try {
      rest = await Dio().post("http://192.168.8.211/cpl_api/game_task_list",
          data: {"version": 3, "device_type": 1});
      // debugPrint(res.data.toString());
    } catch (e) {
      return print(e);
    }
    setState(() {
      res = rest;
    });
  }

  void initState() {
    super.initState();
    getHttp();
  }

  List<Widget> siliverBar(BuildContext context, bool bodyIsScrolled) {
    return <Widget>[
      SliverAppBar(
        pinned: true,
        title: Text(""),
        // snap: true,
        // floating: true,
        primary: true,
        forceElevated: false,
        centerTitle: false,
        titleSpacing: 0.0,
        expandedHeight: window.physicalSize.height * 0.12,
        flexibleSpace: FlexibleSpaceBar(
            background: Container(
          child: Column(
            children: <Widget>[
              newAvatar("RomilaHe", 100, 24, context, "UserDetail"),
              Text(
                'RomilaHe',
                style: TextStyle(fontSize: 20, color: Colors.white),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        )),
        bottom: new TabBar(
          labelStyle: TextStyle(fontSize: 18),
          unselectedLabelStyle: TextStyle(fontSize: 16),
          indicatorWeight: 2.0,
          tabs: <Tab>[
            new Tab(text: '账户'),
            new Tab(text: '通用'),
            new Tab(text: '其他'),
          ],
        ),
      )
    ];
  }

  Widget _getContainer(String test, IconData icon) {
    return new Padding(
      padding: EdgeInsets.all(0),
      child: new ListTile(
        leading: new Icon(icon),
        title: new Text(test),
      ),
    );
  }

  Widget _doubleRowContainer(String mainText, String subText, IconData icon) {
    return new Padding(
      padding: EdgeInsets.all(0),
      child: new ListTile(
        leading: new Icon(icon),
        title: new Text(mainText),
        subtitle: new Text(
          subText,
          style: TextStyle(color: Colors.blue),
        ),
      ),
    );
  }

  showD(String opTitle, List<String> opList) {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, state) {
              return SimpleDialog(
                  title: Text(opTitle), children: buildDia(opTitle, opList));
            },
          );
        });
  }

  List buildDia(i, opList) {
    List<Widget> aaa = [];
    for (var x in opList) {
      aaa.add(new RadioListTile(
          groupValue: bl[i],
          onChanged: (value) {
            setState(() {
              bl[i] = value;
            });
            Navigator.of(context).pop();
          },
          value: x,
          title: Text(x)));
    }
    return aaa;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: siliverBar,
            body: new TabBarView(
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    InkWell(
                      child: _getContainer('升级至高级用户', Icons.stars),
                      onTap: () {},
                    ),
                    Divider(),
                    InkWell(
                      child: _getContainer('账户详情', Icons.person_outline),
                      onTap: () {
                        Navigator.pushNamed(context, 'UserDetail');
                      },
                    ),
                    Divider(),
                    InkWell(
                        child: _getContainer('通知', Icons.notifications_none),
                        onTap: () {}),
                    Divider(),
                    InkWell(
                        child: _getContainer('登出', Icons.exit_to_app),
                        onTap: () {}),
                  ],
                ),
                ListView(
                  children: <Widget>[
                    InkWell(
                      child: _getContainer('智能清单', Icons.format_list_numbered),
                      onTap: () {},
                    ),
                    Divider(),
                    InkWell(
                      child: _getContainer('背景', Icons.image),
                      onTap: () {},
                    ),
                    Divider(),
                    InkWell(
                      child: _doubleRowContainer(
                          '添加任务', bl['添加任务'].toString(), Icons.playlist_add),
                      onTap: () {
                        showD('添加任务', ['清单顶部', '清单底部']);
                      },
                    ),
                    Divider(),
                    InkWell(
                      child: _doubleRowContainer(
                          '星标任务', bl['星标任务'].toString(), Icons.star_border),
                      onTap: () {
                        showD('星标任务', ['将星标任务移到顶部', '固定位置']);
                      },
                    ),
                    Divider(),
                    InkWell(
                        child: _doubleRowContainer(
                            '推迟提醒', bl['推迟提醒'].toString(), Icons.watch_later),
                        onTap: () {
                          showD('推迟提醒', ['5分', '10分']);
                        }),
                    Divider(),
                    InkWell(
                      child: Row(
                        children: <Widget>[
                          // Expanded(child: _getContainer('启用自动提醒', Icons.alarm),flex: 5,),
                          Expanded(
                            child: new CheckboxListTile(
                              secondary: const Icon(Icons.alarm),
                              title: const Text('启用自动提醒'),
                              value: ckvalue,
                              onChanged: (bool val) {
                                setState(() {
                                  ckvalue = val;
                                });
                              },
                            ),
                            flex: 1,
                          )
                        ],
                      ),
                      onTap: () {},
                    ),
                    Divider(),
                    InkWell(
                      child: _getContainer('智能到期日', Icons.calendar_today),
                      onTap: () {},
                    ),
                    Divider(),
                    InkWell(
                      child: _getContainer('声音', Icons.volume_up),
                      onTap: () {},
                    ),
                    Divider(),
                    InkWell(
                      child: _getContainer('插件', Icons.event),
                      onTap: () {},
                    ),
                    Divider(),
                    InkWell(
                      child: _doubleRowContainer(
                          'Android Wear', '已断开连接', Icons.android),
                      onTap: () {},
                    ),
                    Divider(),
                    InkWell(
                      child: _doubleRowContainer('恢复已删除的清单',
                          'www.wunderlist.com/restore', Icons.delete),
                      onTap: () {},
                    ),
                  ],
                ),
                ListView(
                  children: <Widget>[
                    InkWell(
                        child: _getContainer('获取支持', Icons.data_usage),
                        onTap: () {}),
                    Divider(),
                    InkWell(
                        child: _getContainer('关于', Icons.report), onTap: () {}),
                    Divider(),
                    InkWell(
                        child: _getContainer('撰写评论', Icons.edit), onTap: () {}),
                  ],
                )
              ],
            ),
          ),
        ),
        length: 3);
  }
}


