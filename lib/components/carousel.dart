import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  final List<Widget> children;
  final initialPage;

  Carousel({this.children, this.initialPage = 0});

  @override
  CarouselState createState() {
    return new CarouselState(initialPage);
  }
}

class CarouselState extends State<Carousel> {
  final initialPage;
  final pageCtrl;

  CarouselState(this.initialPage)
      : pageCtrl = new PageController(initialPage: initialPage);

  @override
  void initState() {
    super.initState();
    pageCtrl.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        PageView(
          controller: pageCtrl,
          children: widget.children,
        ),
        Positioned(
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: ConstrainedBox(
            constraints: new BoxConstraints.expand(height: 0.0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.children.length,
                      (i) => _buildAnchor(i),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  _buildAnchor(pageId) {
    final currentPageId = pageCtrl.hasClients
        ? pageCtrl.page.roundToDouble()
        : pageCtrl.initialPage;
    return GestureDetector(
      onTap: () {
        pageCtrl.animateToPage(
          pageId,
          duration: Duration(milliseconds: 350),
          curve: Curves.easeOut,
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: SizedBox.fromSize(
          size: Size.square(15.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: currentPageId == pageId ? Colors.black : Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}