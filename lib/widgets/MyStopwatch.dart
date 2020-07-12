import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class MyStopwatch extends StatefulWidget {
  @override
  _MyStopwatchState createState() => _MyStopwatchState();
}

class _MyStopwatchState extends State<MyStopwatch> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  bool runningStatus = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: StreamBuilder<int>(
          stream: _stopWatchTimer.rawTime,
          initialData: 0,
          builder: (context, snap) {
            final value = snap.data;
            final displayTime = StopWatchTimer.getDisplayTime(value);
            return Container(
              decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(20.0)),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      displayTime,
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Helvetica',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    icon: runningStatus
                        ? Icon(Icons.pause)
                        : Icon(Icons.play_arrow),
                    color: Colors.white,
                    iconSize: 36.0,
                    onPressed: () {
                      if (runningStatus == false) {
                        _stopWatchTimer.onExecute.add(StopWatchExecute.start);
                        
                       Toast.show("Start", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);
                    
                        setState(() {
                          runningStatus = true;
                        });
                      } else if (runningStatus == true) {
                        _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
                        Toast.show("Stop", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER,backgroundColor: Colors.redAccent);
                        setState(() {
                          runningStatus = false;
                          
                        });
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.crop_square),
                    color: Colors.red,
                    iconSize: 36.0,
                    onPressed: () {
                       Toast.show("Reset", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                      _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
                      setState(() {
                        runningStatus = false;
                      });
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
