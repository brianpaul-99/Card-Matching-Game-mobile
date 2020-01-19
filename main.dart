import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:card_matching_game/kard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => new _HomePage();
}

class _HomePage extends State<HomePage> {
  bool comparing = false;

  String item1 = '';

  GlobalKey<FlipCardState> cKey;

  int matched = 0;

  List<String> items = [
    'https:\/\/cdn.shopify.com\/s\/files\/1\/1000\/7970\/products\/Aerodynamic_20Concrete_20Clock.png?v=1443055734',
    'https:\/\/cdn.shopify.com\/s\/files\/1\/1000\/7970\/products\/Aerodynamic_20Cotton_20Keyboard.png?v=1443055852',
    'https:\/\/cdn.shopify.com\/s\/files\/1\/1000\/7970\/products\/Aerodynamic_20Granite_20Plate.png?v=1443055768',
    'https:\/\/cdn.shopify.com\/s\/files\/1\/1000\/7970\/products\/Aerodynamic_20Linen_20Computer.png?v=1443055794',
    'https:\/\/cdn.shopify.com\/s\/files\/1\/1000\/7970\/products\/Aerodynamic_20Rubber_20Shoes.png?v=1443055892',
    'https:\/\/cdn.shopify.com\/s\/files\/1\/1000\/7970\/products\/Aerodynamic_20Wooden_20Table.png?v=1443055911',
    'https:\/\/cdn.shopify.com\/s\/files\/1\/1000\/7970\/products\/Awesome_20Bronze_20Bag.png?v=1443055746',
    'https:\/\/cdn.shopify.com\/s\/files\/1\/1000\/7970\/products\/Awesome_20Bronze_20Computer.png?v=1443055880',
    'https:\/\/cdn.shopify.com\/s\/files\/1\/1000\/7970\/products\/Awesome_20Concrete_20Watch.png?v=1443055782',
    'https:\/\/cdn.shopify.com\/s\/files\/1\/1000\/7970\/products\/Awesome_20Copper_20Chair.png?v=1443055799',
    'https:\/\/cdn.shopify.com\/s\/files\/1\/1000\/7970\/products\/Aerodynamic_20Linen_20Computer.png?v=1443055794',
    'https:\/\/cdn.shopify.com\/s\/files\/1\/1000\/7970\/products\/Awesome_20Bronze_20Bag.png?v=1443055746',
    'https:\/\/cdn.shopify.com\/s\/files\/1\/1000\/7970\/products\/Awesome_20Concrete_20Watch.png?v=1443055782',
    'https:\/\/cdn.shopify.com\/s\/files\/1\/1000\/7970\/products\/Awesome_20Bronze_20Computer.png?v=1443055880',
    'https:\/\/cdn.shopify.com\/s\/files\/1\/1000\/7970\/products\/Aerodynamic_20Cotton_20Keyboard.png?v=1443055852',
    'https:\/\/cdn.shopify.com\/s\/files\/1\/1000\/7970\/products\/Aerodynamic_20Rubber_20Shoes.png?v=1443055892',
    'https:\/\/cdn.shopify.com\/s\/files\/1\/1000\/7970\/products\/Aerodynamic_20Concrete_20Clock.png?v=1443055734',
    'https:\/\/cdn.shopify.com\/s\/files\/1\/1000\/7970\/products\/Awesome_20Copper_20Chair.png?v=1443055799',
    'https:\/\/cdn.shopify.com\/s\/files\/1\/1000\/7970\/products\/Aerodynamic_20Granite_20Plate.png?v=1443055768',
    'https:\/\/cdn.shopify.com\/s\/files\/1\/1000\/7970\/products\/Aerodynamic_20Wooden_20Table.png?v=1443055911',
  ];

  List<GlobalKey<FlipCardState>> keys = [
    new GlobalKey<FlipCardState>(),
    new GlobalKey<FlipCardState>(),
    new GlobalKey<FlipCardState>(),
    new GlobalKey<FlipCardState>(),
    new GlobalKey<FlipCardState>(),
    new GlobalKey<FlipCardState>(),
    new GlobalKey<FlipCardState>(),
    new GlobalKey<FlipCardState>(),
    new GlobalKey<FlipCardState>(),
    new GlobalKey<FlipCardState>(),
    new GlobalKey<FlipCardState>(),
    new GlobalKey<FlipCardState>(),
    new GlobalKey<FlipCardState>(),
    new GlobalKey<FlipCardState>(),
    new GlobalKey<FlipCardState>(),
    new GlobalKey<FlipCardState>(),
    new GlobalKey<FlipCardState>(),
    new GlobalKey<FlipCardState>(),
    new GlobalKey<FlipCardState>(),
    new GlobalKey<FlipCardState>(),
  ];

  void setCards(String item, GlobalKey<FlipCardState> cardKey) {
    if (item1 == '') {
      setState((){
      item1 = item;
      cKey = cardKey;

      });

    } else {
      setState(() {
        comparing = true;
      });

      if (item1 != item) {
        Future.delayed(Duration(seconds: 1, milliseconds: 50), () {
          cKey.currentState.toggleCard();
          cardKey.currentState.toggleCard();

          setState(() {
            item1 = '';
            comparing = false;
          });
        });
      } else {
        setState(() {
          matched++;
          item1 = '';
          comparing = false;

          if (matched == 10) {
            showEndDialog(context);
          }
        });
      }
    }
  }

  void restart() {
    setState(() {
      matched = 0;
      item1 = '';
      items.shuffle();
    });
    for (GlobalKey<FlipCardState> key in keys) {
      if (!key.currentState.isFront) {
        key.currentState.toggleCard();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    items.shuffle();
  }

  void showEndDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            title: new Text(
              'Congratulations!!',
              textAlign: TextAlign.center,
            ),
            content: new Text(
              'You have matched all ten pairs',
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              new FlatButton(
                child: Text(
                  'New Game',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  restart();
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(
                width: 30,
              ),
              new FlatButton(
                child: Text(
                  'Quit',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(
                width: 15,
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green[600],
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Kard(
                    itemPath: items[0],
                    cardKey: keys[0],
                    checkCards: setCards,
                    comparing: comparing),
                Kard(
                    itemPath: items[1],
                    cardKey: keys[1],
                    checkCards: setCards,
                    comparing: comparing),
                Kard(
                    itemPath: items[2],
                    cardKey: keys[2],
                    checkCards: setCards,
                    comparing: comparing),
                Kard(
                    itemPath: items[3],
                    cardKey: keys[3],
                    checkCards: setCards,
                    comparing: comparing),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Kard(
                    itemPath: items[4],
                    cardKey: keys[4],
                    checkCards: setCards,
                    comparing: comparing),
                Kard(
                    itemPath: items[5],
                    cardKey: keys[5],
                    checkCards: setCards,
                    comparing: comparing),
                Kard(
                    itemPath: items[6],
                    cardKey: keys[6],
                    checkCards: setCards,
                    comparing: comparing),
                Kard(
                    itemPath: items[7],
                    cardKey: keys[7],
                    checkCards: setCards,
                    comparing: comparing),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Kard(
                    itemPath: items[8],
                    cardKey: keys[8],
                    checkCards: setCards,
                    comparing: comparing),
                Kard(
                    itemPath: items[9],
                    cardKey: keys[9],
                    checkCards: setCards,
                    comparing: comparing),
                Kard(
                    itemPath: items[10],
                    cardKey: keys[10],
                    checkCards: setCards,
                    comparing: comparing),
                Kard(
                    itemPath: items[11],
                    cardKey: keys[11],
                    checkCards: setCards,
                    comparing: comparing),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Kard(
                    itemPath: items[12],
                    cardKey: keys[12],
                    checkCards: setCards,
                    comparing: comparing),
                Kard(
                    itemPath: items[13],
                    cardKey: keys[13],
                    checkCards: setCards,
                    comparing: comparing),
                Kard(
                    itemPath: items[14],
                    cardKey: keys[14],
                    checkCards: setCards,
                    comparing: comparing),
                Kard(
                    itemPath: items[15],
                    cardKey: keys[15],
                    checkCards: setCards,
                    comparing: comparing),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Kard(
                    itemPath: items[16],
                    cardKey: keys[16],
                    checkCards: setCards,
                    comparing: comparing),
                Kard(
                    itemPath: items[17],
                    cardKey: keys[17],
                    checkCards: setCards,
                    comparing: comparing),
                Kard(
                    itemPath: items[18],
                    cardKey: keys[18],
                    checkCards: setCards,
                    comparing: comparing),
                Kard(
                    itemPath: items[19],
                    cardKey: keys[19],
                    checkCards: setCards,
                    comparing: comparing),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      colors: [Colors.green[700], Colors.green[900]],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    )),
                    width: 60,
                    height: 35,
                    child: Center(
                      child: RaisedButton(
                        color: Colors.transparent,
                        onPressed: () => restart(),
                        elevation: 10,
                        child:
                            Icon(Icons.refresh, size: 30, color: Colors.orange),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                              Colors.green[700],
                              Colors.green[800],
                            ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight)),
                        padding: EdgeInsets.only(left: 5),
                        width: 130,
                        height: 32,
                        child: Text(
                          'Matches: ' + matched.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                          textAlign: TextAlign.center,
                        ))),
                SizedBox(
                  width: 60,
                ),
              ],
            )
          ],
        ));
  }
}
