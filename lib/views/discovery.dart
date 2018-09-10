import 'dart:async';

import 'package:flutter/material.dart';
import '../components/content.dart';
import '../components/httpClient.dart';

class Discovery extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DiscoveryState();
  }
}

class DiscoveryState extends State<Discovery> with SingleTickerProviderStateMixin {
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
    Map data =
        await HttpClient.get('/api/v5/index/tab/discovery', param: {'page': 0});

    setState(() {
      this.list = data['itemList'];
    });
  }
}
