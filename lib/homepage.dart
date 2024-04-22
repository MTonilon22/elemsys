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
  bool isCooldownActive = false;
  bool selectorsEnabled = true; // Flag to track whether selectors are enabled

  // Function to reset the timer
  void resetTimer() {
    if (!isTimerRunning && !isCooldownActive) {
      setState(() {
        hours = 0;
        minutes = 0;
        seconds = 0;
        selectorsEnabled = true; // Enable selectors when resetting timer
      });
    }
  }

  // Function to start the timer
  void startTimer() {
    if (!isTimerRunning && !isCooldownActive) {
      int totalSeconds = hours * 3600 + minutes * 60 + seconds;
      timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
        if (totalSeconds < 1) {
          setState(() {
            isTimerRunning = false;
            selectorsEnabled = true; // Enable selectors when timer stops
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
      selectorsEnabled = false; // Disable selectors when timer starts
    }
  }

  // Function to stop the timer
  void stopTimer() {
    if (isTimerRunning) {
      setState(() {
        isTimerRunning = false;
        selectorsEnabled = true; // Enable selectors when timer stops
      });
      timer.cancel();
    }
  }

  // Function to start the cooldown timer
  void startCooldownTimer() {
    isCooldownActive = true;
    Timer(Duration(seconds: 10), () {
      setState(() {
        isCooldownActive = false;
      });
    });
  }

  // Function to show confirmation dialog
  Future<void> showConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Feeding Confirmation'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Pet food now?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                startTimer();
                startCooldownTimer();
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 320, // Adjust the height as needed
            child: Container(
              color: Color(0XFF5a8ad0),
              child: Center(
                child: SizedBox(
                  width: 130, // Adjust width as needed
                  height: 70, // Adjust height as needed
                  child: ElevatedButton(
                    onPressed: isCooldownActive ? null : showConfirmationDialog,
                    child: Text(
                      'QUICK FEED',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0XFFfe7c08),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'SET TIMER',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Timer: ${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Hours Selector
                      Column(
                        children: [
                          Text('Hours'),
                          DropdownButton<int>(
                            value: hours,
                            onChanged: selectorsEnabled
                                ? (value) {
                                    setState(() {
                                      hours = value!;
                                    });
                                  }
                                : null,
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
                      SizedBox(width: 50),
                      // Minutes Selector
                      Column(
                        children: [
                          Text('Minutes'),
                          DropdownButton<int>(
                            value: minutes,
                            onChanged: selectorsEnabled
                                ? (value) {
                                    setState(() {
                                      minutes = value!;
                                    });
                                  }
                                : null,
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
                      SizedBox(width: 50),
                      // Seconds Selector
                      Column(
                        children: [
                          Text('Seconds'),
                          DropdownButton<int>(
                            value: seconds,
                            onChanged: selectorsEnabled
                                ? (value) {
                                    setState(() {
                                      seconds = value!;
                                    });
                                  }
                                : null,
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
                        child: Text(
                          'RESET',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(30),
                          foregroundColor: Colors.white,
                          backgroundColor:
                              Color(0XFFD30000), // Change the color as needed
                        ),
                      ),
                      SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: isTimerRunning || !selectorsEnabled
                            ? null
                            : startTimer,
                        child: Text(
                          'START',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(30),
                          foregroundColor: Colors.white,
                          backgroundColor:
                              Color(0XFF1F8505), // Change the color as needed
                        ),
                      ),
                      SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: stopTimer,
                        child: Text(
                          'STOP',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(30),
                          foregroundColor: Colors.white,
                          backgroundColor:
                              Color(0XFFe7a517), // Change the color as needed
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  // Function to print timer values to terminal
}
