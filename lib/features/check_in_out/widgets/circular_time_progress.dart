import 'dart:async';

import 'package:flutter/material.dart';
import 'package:para_job/packages/themeing/app_colors.dart';

class CheckInOutCircularProgress extends StatefulWidget {
  final String? from;
  final String? to;
  final DateTime? checkInAt;

  const CheckInOutCircularProgress({super.key, this.from, this.to, this.checkInAt});

  @override
  State<CheckInOutCircularProgress> createState() => _CheckInOutCircularProgressState();
}

class _CheckInOutCircularProgressState extends State<CheckInOutCircularProgress> {
  late Timer _timer;
  late DateTime _now;
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _calculateProgress();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _now = DateTime.now();
        _calculateProgress();
      });
    });
  }

  void _calculateProgress() {
    if (widget.from == null || widget.to == null || widget.checkInAt == null) {
      _progress = 0.0;
      return;
    }

    final today = DateTime(_now.year, _now.month, _now.day);
    final fromParts = widget.from!.split(':').map((e) => int.parse(e)).toList();
    final toParts = widget.to!.split(':').map((e) => int.parse(e)).toList();

    final fromTime = today.add(Duration(hours: fromParts[0], minutes: fromParts[1], seconds: fromParts[2]));
    final toTime = today.add(Duration(hours: toParts[0], minutes: toParts[1], seconds: toParts[2]));

    final totalDuration = toTime.difference(fromTime).inSeconds.toDouble();

    final elapsed = _now.difference(widget.checkInAt!).inSeconds.toDouble();

    _progress = (elapsed / totalDuration).clamp(0.0, 1.0);
  }


  String get elapsedTimeString {
    if (widget.checkInAt == null) return "00:00:00";
    final duration = _now.difference(widget.checkInAt!);
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 220,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 220,
            height: 220,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                border: Border.all(
                  color: AppColors.white10,
                  width: 2,
                ),
              ))
          ),
          SizedBox(
            width: 220,
            height: 220,
            child: CircularProgressIndicator(
              value: _progress,
              strokeWidth: 12,
              backgroundColor: Colors.transparent,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.aquaTeal),
              strokeCap: StrokeCap.round,
            ),
          ),
          Text(
            elapsedTimeString,
            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
