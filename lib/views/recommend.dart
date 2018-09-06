import 'package:flutter/material.dart';
import '../components/carousel.dart';
import 'package:dio/dio.dart';

class Recommend extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RecommendState();
  }
}

class RecommendState extends State<Recommend> {
  var allRecs = [];

  @override
  void initState() {
    getAllRecs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: allRecs.length,
      itemBuilder: (context, index) {
        final item = allRecs[index];
        final type = item['type'];
        final data = item['data'];
        print('item: ${item}');

        if ('squareCardCollection' == type) {
          // banner
          final List _banners = data['itemList'];
          return Container(
            height: 290.0,
            child: Carousel(
                children: _banners.map((item) {
              var _header = item['data']['header'];
              return Column(
                children: [
                  Image.network(
                      item['data']['content']['data']['cover']['feed']),
                  ListTile(
                    leading: CircleAvatar(
                      child: Image.network(_header['icon']),
                    ),
                    title: Text(
                      _header['title'],
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      _header['description'],
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing:
                        IconButton(icon: Icon(Icons.share), onPressed: () {}),
                  ),
                  Divider(
                    height: 0.0,
                  ),
                ],
              );
            }).toList()),
          );
        } else if ('textCard' == type) {
          return ListTile(
            title: Row(
              children: <Widget>[
                Text(
                  '旅行',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                ),
                Icon(Icons.chevron_right)
              ],
            ),
          );
        } else if ('pictureFollowCard' == type) {
          return Column(
            children: <Widget>[
              Image.network(data['header']['icon'])
            ],
          );
        }

//        // text card
//        ListTile(
//        title: Row(
//        children: <Widget>[
//        Text(
//        '旅行',
//        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
//        ),
//        Icon(Icons.chevron_right)
//        ],
//        ),
//        ),
//
//        // picture follow card
      },
    );
  }

  getAllRecs() async {
    Dio dio = new Dio();
    Response<Map> response =
        await dio.get("http://baobab.kaiyanapp.com/api/v5/index/tab/allRec",
            options: Options(headers: {
              'User-Agent':
                  'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36'
            }));
    print(response.data);
    var data = response.data;

    setState(() {
      this.allRecs = data['itemList'];
    });
  }
}
