import 'dart:async';

import 'package:flutter/material.dart';
import '../components/content.dart';
import '../components/httpClient.dart';

class CategoryView extends StatefulWidget {
  final int id;

  CategoryView(this.id);

  @override
  State<StatefulWidget> createState() {
    return CategoryViewState(id);
  }
}

class CategoryViewState extends State<CategoryView> with SingleTickerProviderStateMixin {
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
    Map data = await HttpClient.get('/api/v5/index/tab/category/${id}');

    setState(() {
      this.list = data['itemList'];
    });
  }
}
