import 'package:flutter/material.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Timer variables
  int hours = 0;
  int minutes = 0;
  int seconds = 0;
  late Timer timer;
  bool isTimerRunning = false;

  // Function to reset the timer
  void resetTimer() {
    if (!isTimerRunning) {
      setState(() {
        hours = 0;
        minutes = 0;
        seconds = 0;
      });
    }
  }

  // Function to start the timer
  void startTimer() {
    if (!isTimerRunning) {
      int totalSeconds = hours * 3600 + minutes * 60 + seconds;
      timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
        if (totalSeconds < 1) {
          setState(() {
            isTimerRunning = false;
          });
          t.cancel();
        } else {
          setState(() {
            totalSeconds--;
            hours = totalSeconds ~/ 3600;
            minutes = (totalSeconds % 3600) ~/ 60;
            seconds = totalSeconds % 60;
          });
        }
      });
      isTimerRunning = true;
    }
  }

  // Function to stop the timer
  void stopTimer() {
    if (isTimerRunning) {
      setState(() {
        isTimerRunning = false;
      });
      timer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feed Me App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Add your logic here for the 'Feed Me' button
              },
              child: Text('Feed Me'),
            ),
            SizedBox(height: 20),
            Text(
              'Set Timer',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Hours Selector
                Column(
                  children: [
                    Text('Hours'),
                    DropdownButton<int>(
                      value: hours,
                      onChanged: (value) {
                        setState(() {
                          hours = value!;
                        });
                      },
                      items: List.generate(
                        24,
                        (index) => DropdownMenuItem<int>(
                          value: index,
                          child: Text(index.toString()),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 20),
                // Minutes Selector
                Column(
                  children: [
                    Text('Minutes'),
                    DropdownButton<int>(
                      value: minutes,
                      onChanged: (value) {
                        setState(() {
                          minutes = value!;
                        });
                      },
                      items: List.generate(
                        60,
                        (index) => DropdownMenuItem<int>(
                          value: index,
                          child: Text(index.toString()),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 20),
                // Seconds Selector
                Column(
                  children: [
                    Text('Seconds'),
                    DropdownButton<int>(
                      value: seconds,
                      onChanged: (value) {
                        setState(() {
                          seconds = value!;
                        });
                      },
                      items: List.generate(
                        60,
                        (index) => DropdownMenuItem<int>(
                          value: index,
                          child: Text(index.toString()),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: resetTimer,
                  child: Text('Reset Timer'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: startTimer,
                  child: Text('Start Timer'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: stopTimer,
                  child: Text('Stop Timer'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Timer: ${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }
}
