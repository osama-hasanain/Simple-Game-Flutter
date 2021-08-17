
import 'dart:math';

import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';

class OrderImages extends StatefulWidget {
  static final String routes = 'orderImages';
  @override
  _OrderImagesState createState() => _OrderImagesState();
}

class _OrderImagesState extends State<OrderImages> {
  var player = AudioPlayer();
  Map<String, bool> score = {};
  Map<String, Color> choices = {
    '🍎': Colors.red,
    '🍌': Colors.yellowAccent,
    '🍇': Colors.purpleAccent,
    '🥒': Colors.green,
    '🍄': Colors.pink[200],
  };
  var index = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Images Order'),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: choices.keys.map((element) {
                return Expanded(
                    child: Draggable<String>(
                  data: element,
                  child: Movable(score[element] == true?'✔️':element),
                  feedback: Movable(element),
                  childWhenDragging: Movable('◻️'),
                ));
              }).toList(),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: choices.keys.map((element){
                return buildTarget(element);
              }).toList()
              ..shuffle(Random(index)),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          backgroundColor: Colors.cyan,
          onPressed: (){
            setState(() {
              score.clear();
            });
          },
        ),
      ),
    );
  }
  Widget buildTarget(element){
    return DragTarget<String>(
      builder: (context,incoming,rejected){
        if(score[element]==true){
          return Container(
            color: Colors.white,
            child: Text('Congratultion!'),
            alignment: Alignment.center,
            height: 80,
            width: 200,
          );
        }else{
          return Container(
            color: choices[element],
            height: 80,
            width: 200,
          );
        }
      },
       onWillAccept: (data) => data == element,
       onAccept: (data){
         setState(() {
           score[element] = true;
           player.play('assests/clap.mp3');
         });
       },
    );
  }
}

class Movable extends StatelessWidget {
  final String emoji;
  Movable(this.emoji);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        padding: EdgeInsets.all(15),
        child: Text(
          emoji,
          style: TextStyle(color: Colors.black, fontSize: 60),
        ),
      ),
    );
  }
}
