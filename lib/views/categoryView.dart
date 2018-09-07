import 'dart:async';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../components/content.dart';

class CategoryView extends StatefulWidget {
  final int id;

  CategoryView(this.id);

  @override
  State<StatefulWidget> createState() {
    return CategoryViewState(id);
  }
}

class CategoryViewState extends State<CategoryView> {
  final int id;
  var list = [];

  CategoryViewState(this.id);

  @override
  void initState() {
    getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: Content(list),
      onRefresh: getList,
    );
  }

  Future getList() async {
    Dio dio = new Dio();
    Response<Map> response = await dio.get(
        "http://baobab.kaiyanapp.com/api/v5/index/tab/category/${id}",
        options: Options(headers: {
          'User-Agent':
              'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36'
        }));
    print(response.data);
    var data = response.data;

    setState(() {
      this.list = data['itemList'];
    });
  }
}
