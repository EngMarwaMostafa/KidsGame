
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
//  var player = AudioCache();
  final Map<String,bool> score = {};
  final Map<String,Color> choices = {
    '🥒':Colors.green,
    '🔵':Colors.blue,
    '🍌':Colors.yellow,
     '🍆':Colors.purple,
     '🍊':Colors.orangeAccent,
      '🥥':Colors.brown,
  };
  int index =0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('COLORS '),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment:CrossAxisAlignment.end,
            children: choices.keys.map((element){
              return Expanded(
                  child: Draggable<String>(
                  data: element,
                    child: Mouvable(score[element] == true ? '✔' : element),
                 feedback: Mouvable(element),
                 childWhenDragging: Mouvable('🐇'),
                 ),
              );
            }).toList(),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: choices.keys.map((element){
              return buildTarget(element);
            }).toList()..shuffle(Random(index)),
          ),
            ],
          ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed:() {
          setState(() {
            score.clear();
            index++;
          });
        },
      ),
    );
  }
    Widget buildTarget(element){
    return DragTarget<String>(
      builder: (context,incoming,rejected){
    if(score[element] == true){
      return Container(
        color: Colors.white,
        child: Text('Congratulations!'),
        alignment: Alignment.center,
        height: 80,
        width: 200,
      );
      }else{
      return Container(color: choices[element],
      height: 80,
        width: 200,
      );
      }
      },
      onWillAccept: (data) => data == element,
      onAccept: (data) => {
        setState(() {
          score[element] = true;
          Text('CONGRAT');
        }),
      },
      onLeave: (data) {},
    );
    }
   }

class Mouvable extends StatelessWidget {
  String emoji;
  Mouvable(this.emoji);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
     child:Container(
       alignment: Alignment.center,
       height: 80,
       padding: EdgeInsets.all(15),
       child:Text(emoji,style: TextStyle(color: Colors.black),) ,
     ),
    );
  }
}

