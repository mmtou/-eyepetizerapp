import 'dart:async';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:math';

class Category extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CategoryState();
  }
}

class CategoryState extends State<Category> {
  List<Map> categories = [];

  @override
  void initState() {
    getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _startY = 0.0;
    var _endY = 0.0;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.keyboard_arrow_left),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text('置顶分类排序'),
      ),
      body: ListView(
        children: categories.asMap().keys.map((index) {
          var item = categories[index];
          return Column(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  child: Image.network(item['bgPicture']),
                ),
                title: Text(item['name']),
                subtitle: Text(item['description']),
                trailing: GestureDetector(
                  child: Icon(Icons.menu),
                  onVerticalDragStart: (detail) {
                    _startY = detail.globalPosition.dy;
                  },
                  onVerticalDragUpdate: (detail) {
                    _endY = detail.globalPosition.dy;
                  },
                  onVerticalDragEnd: (detail) {
                    print('_index: ${index}');
                    var _distance = _endY - _startY;
                    print('_distance: ${_distance}');
                    int offset = (_distance / 72.0).toInt();
                    print('offset: ${offset}');
                    var currentIndex = index + offset;
                    print('currentIndex: ${currentIndex}');
                    if (currentIndex < 0) {
                      currentIndex = 0;
                    } else if (currentIndex >= categories.length) {
                      currentIndex = categories.length - 1;
                    }
                    print('currentIndex: ${currentIndex}');
                    categories.remove(item);
                    categories.insert(currentIndex, item);
                    setState(() {
                      this.categories = categories;
                    });
                  },
                ),
                onTap: () {
//                  Navigator.pop(context);
                },
              ),
              Divider(
                height: 0.0,
              ),
            ],
          );
        }).toList(),
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
    int _index = 0;
    response.data.map((item) {
      categories.add({
        'name': item['name'],
        'description': item['description'],
        'bgPicture': item['bgPicture'],
      });
    }).toList();

    setState(() {
      this.categories = categories;
    });
  }
}
