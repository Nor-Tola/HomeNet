import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'dart:async';

final timeProvider = StreamProvider<DateTime>((ref) async* {
  yield DateTime.now(); 
  yield* Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now());
});

String greeting(DateTime time) {
  int hour = time.hour;
  if (hour < 12) return 'Good Morning';
  if (hour < 18) return 'Good Afternoon';
  return 'Good Evening';
}

String formatTime(DateTime time) {
  return DateFormat('HH:mm:ss').format(time); 
}