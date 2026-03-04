import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homecontrol/Controller/TimeController.dart';
import 'package:homecontrol/Model/room_model.dart';
import 'package:homecontrol/Controller/roomController.dart';

PreferredSizeWidget appBarWidget(WidgetRef ref) {
  final timeAsync = ref.watch(timeProvider);
  final rooms = ref.watch(roomProvider);
  final allDevices = rooms.expand((room) => room.allDevice).toList();
  return AppBar(
    automaticallyImplyLeading: false,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        timeAsync.when(
          data: (time) => Text(
            '${greeting(time)}',
            style: TextStyle(fontSize: 15, color: Colors.black54),
          ),
          loading: () => Text('Loading...'),
          error: (err, _) => Text('Error'),
        ),
        SizedBox(height: 4),
        Text(
          'ah smos 👋',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
        ),
      ],
    ),
    actions: [
      timeAsync.when(
        data: (time) => Text(
          'Time : ${formatTime(time)}',
          style: TextStyle(
            fontSize: 17,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        loading: () => Text('Loading...'),
        error: (err, _) => Text('Error'),
      ),
      SizedBox(width: 20),
    ],
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(100),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: Icon(Icons.home),
                title: Text('Main'),
                subtitle: Text(
                  'Phone Penh, ${roomList.length} rooms, ${allDevices.length} devices',
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
