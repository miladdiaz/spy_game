import 'dart:async';
import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  final Duration time;
  const TimerWidget({super.key, required this.time});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Duration? duration;
  bool isEnded = false;
  Timer? timer;
  DateTime? end;

  @override
  void initState() {
    end = DateTime.now().add(widget.time);
    duration = Duration(seconds: end!.difference(DateTime.now()).inSeconds);

    timer = Timer.periodic(const Duration(seconds: 1), (t) => countDown());
    super.initState();
  }

  void countDown() {
    final DateTime now = DateTime.now();
    print(end!.difference(DateTime.now()));

    setState(() {
      if (now.isAfter(end!)) {
        isEnded = true;
        timer?.cancel();
        return;
      }

      duration = Duration(seconds: end!.difference(now).inSeconds);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.80,
      width: MediaQuery.of(context).size.width * 0.80,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          isEnded
              ? "Time's Up!"
              : duration == null
                  ? "00:00"
                  : '${duration!.inMinutes < 10 ? 0 : ""}${duration!.inMinutes}:${duration!.inSeconds.remainder(60) < 10 ? 0 : ""}${duration!.inSeconds.remainder(60)}',
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
