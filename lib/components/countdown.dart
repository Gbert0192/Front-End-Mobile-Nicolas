import 'dart:async';
import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';
import 'package:flutter/material.dart';

enum Metrics { second, minute, hour }

class CountdownTimer extends StatefulWidget {
  final Color color;
  final double fontSize;
  final int countLong;
  final Function(int)? countDownFunction;
  final bool isSmall;
  final Metrics unit;

  const CountdownTimer({
    required this.isSmall,
    required this.countLong,
    this.countDownFunction,
    this.color = Colors.black,
    this.unit = Metrics.minute,
  }) : fontSize = isSmall ? 15 : 18;

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
        widget.countDownFunction?.call(_secondsRemaining);
      } else {
        setState(() {
          _secondsRemaining--;
        });
        widget.countDownFunction?.call(_secondsRemaining);
      }
    });
  }

  String formatDuration(int totalSeconds) {
    final duration = Duration(seconds: totalSeconds);

    switch (widget.unit) {
      case Metrics.hour:
        final hours = duration.inHours.toString().padLeft(2, '0');
        final minutes = duration.inMinutes
            .remainder(60)
            .toString()
            .padLeft(2, '0');
        final seconds = duration.inSeconds
            .remainder(60)
            .toString()
            .padLeft(2, '0');
        return "$hours:$minutes:$seconds";
      case Metrics.minute:
        final minutes = duration.inMinutes.toString().padLeft(2, '0');
        final seconds = duration.inSeconds
            .remainder(60)
            .toString()
            .padLeft(2, '0');
        return "$minutes:$seconds";
      case Metrics.second:
        return duration.inSeconds.toString();
    }
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
      style: TextStyle(fontSize: widget.fontSize, color: widget.color),
    );
  }
}
