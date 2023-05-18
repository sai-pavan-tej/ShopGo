import 'package:flutter/material.dart';
import 'ViewPage.dart';

class ItemSummary extends StatelessWidget {
  final bool horizontal;
  var item;

  ItemSummary(this.item, {this.horizontal = true});

  ItemSummary.vertical(this.item) : horizontal = false;

  @override
  Widget build(BuildContext context) {
    // final ItemThumbnail = new Container(
    //   margin: new EdgeInsets.symmetric(vertical: 16.0),
    //   alignment:
    //       horizontal ? FractionalOffset.centerLeft : FractionalOffset.center,
    //   child: new Hero(
    //     tag: "Santoor",
    //     child: new Image(
    //       image: new AssetImage(planet.image),
    //       height: 92.0,
    //       width: 92.0,
    //     ),
    //   ),
    // );
    Widget _planetValue({String value}) {
      return new Container(
        child: new Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
          // new Image.asset(image, height: 12.0),
          new Container(width: 8.0),
          new Text(value,
              style: TextStyle(fontFamily: 'Poppins').copyWith(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600)),
        ]),
      );
    }

    final planetCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(76.0, 10.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(height: 2.0),
          new Text("Dyna Soap",
              style: TextStyle(fontFamily: 'Poppins').copyWith(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600)),
         Container(height: 5.0),
          Padding(
            padding: const EdgeInsets.only(left: 23.0),
            child: Text("400 g",
                style: TextStyle(fontFamily: 'Poppins').copyWith(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 27.0),
            child: Container(
                margin: new EdgeInsets.symmetric(vertical: 8.0),
                height: 2.0,
                width: 18.0,
                color: new Color(0xff00c6ff)),
          ),
          
          Padding(
            padding: const EdgeInsets.only(left: 7.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Expanded(
                  flex: 1,
                  child: _planetValue(
                    value: "Rs. 64",
                  ),
                  //       //  new Container (
                  //       //    width: 32.0,
                  //       //  ),
                  //       //  new Expanded(
                  //       //      flex: horizontal ? 1 : 0,
                  //       //      child: _planetValue(
                  //       //      value: planet.gravity,
                  //       //      image: 'assets/img/ic_gravity.png')
                )
              ],
            ),
          ),
        ],
      ),
    );

    final planetCard = new Container(
      child: planetCardContent,
      height: horizontal ? 124.0 : 154.0,
      margin: horizontal
          ? new EdgeInsets.only(left: 46.0)
          : new EdgeInsets.only(top: 72.0),
      decoration: new BoxDecoration(
        color: Colors.black54,
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
    );
    return new GestureDetector(
        onTap: horizontal
            ? () => Navigator.of(context).push(
                  new PageRouteBuilder(
                    pageBuilder: (_, __, ___) => new ViewPage("Santoor"),
                    transitionsBuilder: (context, animation, secondaryAnimation,
                            child) =>
                        new FadeTransition(opacity: animation, child: child),
                  ),
                )
            : null,
        child: new Container(
          margin: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 24.0,
          ),
          child: new Stack(
            children: <Widget>[
              planetCard,
            ],
          ),
        ));
  }
}
