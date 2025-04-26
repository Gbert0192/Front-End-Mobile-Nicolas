import 'dart:async';
import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  final int countLong; // in seconds

  const CountdownTimer({super.key, required this.countLong});

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late int _secondsRemaining;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _secondsRemaining = widget.countLong;
    startCountdown();
  }

  void startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        timer.cancel();
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  String formatDuration(int totalSeconds) {
    final duration = Duration(seconds: totalSeconds);
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      formatDuration(_secondsRemaining),
      style: const TextStyle(fontSize: 48),
    );
  }
}
