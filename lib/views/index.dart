import 'dart:async';

import 'package:flutter/material.dart';
import 'discovery.dart';
import 'recommend.dart';
import 'categoryView.dart';
import 'package:dio/dio.dart';

class Index extends StatefulWidget {
  final int tabIndex;

  Index({this.tabIndex: 1});

  @override
  State<StatefulWidget> createState() {
    return new IndexState(tabIndex);
  }
}

class IndexState extends State<Index> {
  int tabIndex;

  IndexState(this.tabIndex);

  int _index = 0;
  List tabs = [
    {'name': '发现'},
    {'name': '推荐'}
  ];
  List<Widget> tabViews = [Discovery(), Recommend()];

  @override
  void initState() {
    getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: tabIndex,
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Navigator.pushNamed(context, '/category');
              }),
          title: TabBar(
            isScrollable: true,
            tabs: tabs.map((tab) => Text(tab['name'])).toList(),
            indicatorSize: TabBarIndicatorSize.label,
          ),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), onPressed: () {}),
          ],
        ),
        body: TabBarView(
          children: tabViews.map((tabView) => tabView).toList(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (int index) {
            setState(() {
              this._index = index;
            });
          },
          currentIndex: _index,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('首页'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.gps_fixed),
              title: Text('关注'),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
              ),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notification_important),
              title: Text('通知'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('我的'),
            ),
          ],
        ),
      ),
    );
  }

  Future getCategories() async {
    Dio dio = new Dio();
    Response<List<dynamic>> response =
        await dio.get("http://baobab.kaiyanapp.com/api/v4/categories",
            options: Options(headers: {
              'User-Agent':
                  'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36'
            }));
    print(response.data);
    response.data.map((item) {
      tabs.add({
        'name': item['name'],
      });
      tabViews.add(CategoryView(item['id']));
    }).toList();

    setState(() {
      this.tabs = tabs;
      this.tabViews = tabViews;
    });
  }
}
