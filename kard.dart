import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class Kard extends StatefulWidget {
  final String itemPath;
  final void Function(String, GlobalKey<FlipCardState>) checkCards;
  final bool comparing;
  final GlobalKey<FlipCardState> cardKey;

  const Kard(
      {Key key,
      @required this.itemPath,
      @required this.checkCards,
      @required this.comparing,
      @required this.cardKey})
      : super(key: key);

  @override
  _Kard createState() => new _Kard();
}

class _Kard extends State<Kard> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Container(
          width: 90.0,
          height: 125.0,
          child: FlipCard(
            key: widget.cardKey,
            direction: FlipDirection.HORIZONTAL,
            front: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [Colors.green, Colors.green[700]],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )),                
                child: RaisedButton(
                  color: Colors.transparent,
                  child: Image.asset('assets/images/shopify_logo.png',
                      fit: BoxFit.cover),
                  onPressed: () {
                    if (!widget.comparing) {
                      widget.cardKey.currentState.toggleCard();
                      print('clicked');                     
                      widget.checkCards(widget.itemPath, widget.cardKey);                      
                    }
                  },
                )),
            back: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [Colors.green[600], Colors.teal[600]],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )),
                child: Image.network(widget.itemPath, fit: BoxFit.cover)),
            flipOnTouch: false,
          ),
        ));
  }
}
