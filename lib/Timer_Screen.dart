import 'dart:async';

import 'package:flutter/material.dart';

class TimerScreen extends StatefulWidget {
  TimerScreen({super.key});
  static const route = "/TimerScreen";

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  final List<int> Laps = [];

  Timer? Mytimer;

  int milliSecond = 0;

  int Second = 0;

  bool isRunning = false;

  final controller = ScrollController();

  double itemheight = 100;

  void Start() {
    Mytimer = Timer.periodic(
      const Duration(milliseconds: 100),
      (timer) {
        (milliSecond += 100);
        setState(() {
          isRunning = true;
        });
      },
    );
  }

  void lap() {
    setState(() {
      Laps.add(milliSecond);
      milliSecond = 0;
      controller.animateTo(
        itemheight * Laps.length,
        duration: const Duration(seconds: 1),
        curve: Curves.linear,
      );
    });
  }

  String SecondText(int milliS) {
    final sec = milliS / 1000;
    return "$sec";
  }

  void Stop() {
    if (isRunning) {
      Mytimer!.cancel();
      setState(() {
        Laps.add(milliSecond);
        milliSecond = 0;

        isRunning = false;
      });
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "This is the Stop watch",
            style: TextStyle(
              color: Mycolors().mygrey,
            ),
          ),
        ),
        backgroundColor: Mycolors().myred,
      ),
      body: Column(
        children: [
          TheController(context),
          TheBodyOFListViwe(),
        ],
      ),
    );
  }

  Expanded TheController(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        color: Mycolors().myred,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "${SecondText(milliSecond)} Second",
              style: TextStyle(fontSize: 35, color: Mycolors().mygrey),
            ),
            SizedBox(
              height: 22,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      Mycolors().mygrey,
                    ),
                  ),
                  onPressed: isRunning ? null : Start,
                  child: Row(
                    children: [
                      Text(
                        "Start",
                        style: TextStyle(color: Mycolors().myred),
                      ),
                      Icon(Icons.not_started_sharp, color: Mycolors().myred),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Mycolors().mygrey),
                  ),
                  onPressed: isRunning ? lap : null,
                  child: Row(
                    children: [
                      Text(
                        "Lap",
                        style: TextStyle(color: Mycolors().myred),
                      ),
                      Icon(Icons.reviews_sharp, color: Mycolors().myred),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Mycolors().mygrey),
                  ),
                  onPressed: isRunning ? Stop : null,
                  child: Row(
                    children: [
                      Text(
                        "Stop",
                        style: TextStyle(color: Mycolors().myred),
                      ),
                      Icon(Icons.auto_delete_rounded, color: Mycolors().myred),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Mycolors().mygrey),
                  ),
                  onPressed: () {
                    Stop();
                    setState(() {
                      Laps.clear();
                      milliSecond = 0;
                    });
                  },
                  child: Row(
                    children: [
                      Text(
                        "Clear",
                        style: TextStyle(color: Mycolors().myred),
                      ),
                      Icon(Icons.cleaning_services_outlined,
                          color: Mycolors().myred),
                    ],
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                setState(
                  () {
                    milliSecond = 0;
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width - 50, 50),
                backgroundColor: Mycolors().mygrey,
              ),
              child: Text(
                "Clear the Second",
                style: TextStyle(color: Mycolors().myred, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded TheBodyOFListViwe() {
    return Expanded(
      flex: 3,
      child: Scrollbar(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListView.builder(
            itemExtent: itemheight,
            controller: controller,
            itemCount: Laps.length,
            itemBuilder: (context, index) {
              return Card(
                color: Mycolors().myred,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Text(
                      "Lap${index + 1}",
                      style: TextStyle(fontSize: 18, color: Mycolors().mygrey),
                    ),
                    trailing: Text(
                      "${(Laps[index] / 1000).toString()} Seconds",
                      style: TextStyle(fontSize: 18, color: Mycolors().mygrey),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class Mycolors {
  final Color mygrey = Color.fromARGB(255, 235, 232, 232);
  final Color myred = Color.fromARGB(255, 140, 0, 0);
}
