import 'package:flutter/material.dart';
import 'package:homecontrol/Model/devices-model.dart';

class RoomModel {
  final String name;
  final IconData icon;
  final List<Device> allDevice;

  RoomModel({
    required this.name,
    required this.icon,
    required this.allDevice,
  });

  bool get isOn =>
      allDevice.any((device) => device.isActive);

  RoomModel copyWith({
    List<Device>? allDevice,
  }) {
    return RoomModel(
      name: name,
      icon: icon,
      allDevice: allDevice ?? this.allDevice,
    );
  }
}

final List<RoomModel> roomList = [
  RoomModel(
    name: 'Living Room',
    icon: Icons.home,
    allDevice: [
      Device(id: 'lr1', name: 'Smart Light', icon: Icons.lightbulb),
      Device(id: 'lr2', name: 'Fan', icon: Icons.toys),
      Device(id: 'lr3', name: 'Temp', icon: Icons.thermostat, degree: 24),
      Device(id: 'lr4', name: 'Motion', icon: Icons.motion_photos_on),
    ],
  ),
  RoomModel(
    name: 'Bed Room',
    icon: Icons.bed,
    allDevice: [
      Device(id: 'br1', name: 'Smart Light', icon: Icons.lightbulb),
      Device(id: 'br2', name: 'Temp', icon: Icons.thermostat, degree: 21),
    ],
  ),
  RoomModel(
    name: 'Kitchen',
    icon: Icons.kitchen,
    allDevice: [
      Device(id: 'k1', name: 'Smart plug', icon: Icons.power_rounded),
      Device(id: 'k2', name: 'Humidity', icon: Icons.opacity),
    ],
  ),
];