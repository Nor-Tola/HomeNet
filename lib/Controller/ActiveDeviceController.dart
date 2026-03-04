import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homecontrol/Controller/roomController.dart';

final activeDeviceCountProvider =
    Provider<int>((ref) {
  final rooms = ref.watch(roomProvider);

  return rooms
      .expand((room) => room.allDevice)
      .where((device) => device.isActive)
      .length;
});