import 'dart:async';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../components/content.dart';

class Recommend extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RecommendState();
  }
}

class RecommendState extends State<Recommend> {
  var list = [];

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
        "http://baobab.kaiyanapp.com/api/v5/index/tab/allRec?page=0",
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
