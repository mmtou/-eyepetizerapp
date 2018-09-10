import 'dart:async';

import 'package:flutter/material.dart';
import 'index.dart';
import '../components/httpClient.dart';

class Category extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CategoryState();
  }
}

class CategoryState extends State<Category>
    with SingleTickerProviderStateMixin {
  List<Map> categories = [];

  @override
  void initState() {
    getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.keyboard_arrow_left),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text('置顶分类排序'),
      ),
      body: ReorderableListView(
        children: categories.map((item) {
          return Column(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  child: Image.network(item['bgPicture']),
                ),
                title: Text(item['name']),
                subtitle: Text(item['description']),
                trailing: Icon(Icons.menu),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Index(
                                tabId: item['id'],
                              )));
                },
              ),
              Divider(
                height: 0.0,
              ),
            ],
            key: Key(item['name']),
          );
        }).toList(),
        onReorder: (oldIndex, newIndex) {
          var item = categories[oldIndex];
          if (oldIndex < newIndex) {
            newIndex = newIndex - 1;
          }
          categories.removeAt(oldIndex);
          categories.insert(newIndex, item);
          setState(() {
            this.categories;
          });
          print('${oldIndex}, ${newIndex}');
        },
      ),
    );
  }

  Future getCategories() async {
    List data = await HttpClient.get('/api/v4/categories');
    data.map((item) {
      categories.add({
        'id': item['id'],
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
