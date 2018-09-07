import 'package:flutter/material.dart';
import '../components/carousel.dart';

class Content extends StatelessWidget {
  @required
  final List list;

  Content(this.list);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        final type = item['type'];
        final data = item['data'];
        print('item: ${item}');

        if ('squareCardCollection' == type) {
          // banner
          final List _banners = data['itemList'];
          return Container(
            height: 281.4,
            child: Carousel(
                children: _banners.map((item) {
              var _header = item['data']['header'];
              return Column(
                children: [
                  Image.network(
                    item['data']['content']['data']['cover']['feed'],
                    height: 217.4,
                    width: 350.0,
                  ),
                  // height = 64.0
                  ListTile(
                    dense: true,
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
                  data['text'],
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                ),
                Icon(Icons.chevron_right)
              ],
            ),
          );
        } else if ('pictureFollowCard' == type) {
          return Column(
            children: <Widget>[
              Image.network(
                data['content']['data']['url'],
                height: 217.4,
                width: 350.0,
              ),
              ListTile(
                leading: CircleAvatar(
                  child: Image.network(data['header']['icon']),
                ),
                subtitle: Text(data['content']['data']['description']),
              )
            ],
          );
        } else if ('banner2' == type) {
          return Image.network(
            data['image'],
            height: 217.4,
            width: 350.0,
          );
        } else if ('followCard' == type) {
          return Column(
            children: [
              Image.network(
                data['content']['data']['cover']['feed'],
                height: 217.4,
                width: 350.0,
              ),
              // height = 64.0
              ListTile(
                dense: true,
                leading: CircleAvatar(
                  child: Image.network(data['header']['icon']),
                ),
                title: Text(
                  data['content']['data']['title'],
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  data['content']['data']['description'],
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(icon: Icon(Icons.share), onPressed: () {}),
              ),
              Divider(
                height: 0.0,
              ),
            ],
          );
        } else if ('videoSmallCard' == type) {
          return Column(
            children: [
              Text(data['playUrl']),
              // height = 64.0
              ListTile(
                dense: true,
                title: Text(
                  data['title'],
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  data['description'],
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(icon: Icon(Icons.share), onPressed: () {}),
              ),
              Divider(
                height: 0.0,
              ),
            ],
          );
        } else if ('briefCard' == type) {
          return Column(
            children: [
              // height = 64.0
              ListTile(
                dense: true,
                leading: CircleAvatar(
                  child: Image.network(data['icon']),
                ),
                title: Text(
                  data['title'],
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  data['description'],
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Divider(
                height: 0.0,
              ),
            ],
          );
        } else if ('videoCollectionWithBrief' == type) {
          // banner
          final List _banners = data['itemList'];
          return Container(
            height: 281.4,
            child: Carousel(
                children: _banners.map((item) {
              var _header = item['data']['header'];
              return Column(
                children: [
                  Image.network(
                    item['data']['content']['data']['cover']['feed'],
                    height: 217.4,
                    width: 350.0,
                  ),
                  // height = 64.0
                  ListTile(
                    dense: true,
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
        }
      },
    );
  }
}
