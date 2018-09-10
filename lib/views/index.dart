import 'dart:async';

import 'package:flutter/material.dart';
import 'discovery.dart';
import 'recommend.dart';
import 'categoryView.dart';
import '../components/httpClient.dart';

class Index extends StatefulWidget {
  final int tabId;

  Index({this.tabId: 1});

  @override
  State<StatefulWidget> createState() {
    return new IndexState(tabId);
  }
}

class IndexState extends State<Index> {
  int tabId;

  IndexState(this.tabId);

  List tabs = ['发现', '推荐'];
  List<Widget> tabViews = [Discovery(), Recommend()];
  Map<int, int> idIndex = {0: 0, 1: 1};

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('tabId: ${tabId}');
    return DefaultTabController(
      initialIndex: idIndex[tabId],
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
            tabs: tabs.map((tab) => Text(tab)).toList(),
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
          onTap: (int index) {},
          currentIndex: 0,
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
    List data = await HttpClient.get('/api/v4/categories');
    var _index = 2;
    data.map((item) {
      tabs.add(item['name']);
      tabViews.add(CategoryView(item['id']));
      idIndex[item['id']] = _index;
      _index++;
    }).toList();

    setState(() {
      this.tabs = tabs;
      this.tabViews = tabViews;
      this.idIndex = idIndex;
    });
  }
}
