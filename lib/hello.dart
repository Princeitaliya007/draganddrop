import 'dart:math';
import 'package:draganddrop/main.dart';
import 'package:flutter/material.dart';

class Hello extends StatefulWidget {
  const Hello({Key? key}) : super(key: key);

  @override
  State<Hello> createState() => _HelloState();
}

class _HelloState extends State<Hello> {
  Map m1 = <String, String>{
    "🏎️": "Car",
    "🐧": "Bird",
    "🙈": "Animal",
  };

  Map m2 = <String, bool>{};

  int i = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello"),
      ),
      body: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: m1.keys
                  .map((e) => Draggable(
                        data: e,
                        child: Emoji(emoji: m2[e] == true ? "✅" : e),
                        feedback: Emoji(emoji: e),
                        childWhenDragging: const Emoji(emoji: "🥰"),
                      ))
                  .toList(),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: m1.entries.map((e) => dragtarget(e)).toList()
                ..shuffle(Random(2)),
            ),
          ],
        ),
      ),
    );
  }

  Widget dragtarget(e) {
    return DragTarget<String>(
      builder: (BuildContext context, List<String?> income, List reject) {
        if (m2[e.key] == true) {
          return Container(
            height: 80,
            width: 100,
            color: Colors.transparent,
            alignment: Alignment.center,
            child: Text(
              "😎",
              style: TextStyle(fontSize: 50),
            ),
          );
        } else {
          return Container(
            height: 80,
            width: 100,
            color: Colors.transparent,
            child: Text(
              e.value,
              style: TextStyle(fontSize: 30),
            ),
          );
        }
      },
      onWillAccept: (data) => data == e.key,
      onAccept: (data) {
        m2[e.key] = true;
        i++;

        if (i == 3) {}
      },
      onLeave: (data) {},
    );
  }
}
