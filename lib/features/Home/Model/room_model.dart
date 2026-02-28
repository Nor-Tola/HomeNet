import 'package:flutter/material.dart';

class Device {
  final String name;
  final IconData icon;
  final bool isActive;
  final int degree;

  Device({
    required this.name,
    required this.icon,
    this.isActive = false,
    this.degree = 0,
  });

  Device copyWith({
    bool? isActive,
    int? degree,
  }) {
    return Device(
      name: name,
      icon: icon,
      isActive: isActive ?? this.isActive,
      degree: degree ?? this.degree,
    );
  }
}

class RoomModel {
  final String name;
  final IconData icon;
  final List<Device> allDevice;

  RoomModel({
    required this.name,
    required this.icon,
    required this.allDevice,
  });

  /// Room is active if ANY device is active
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
      Device(name: 'Smart Light', icon: Icons.lightbulb),
      Device(name: 'Fan', icon: Icons.toys),
      Device(name: 'Temp', icon: Icons.thermostat, degree: 24),
      Device(name: 'Motion', icon: Icons.motion_photos_on),
    ],
  ),
  RoomModel(
    name: 'Bed Room',
    icon: Icons.bed,
    allDevice: [
      Device(name: 'Smart Light', icon: Icons.lightbulb),
      Device(name: 'Temp', icon: Icons.thermostat, degree: 21),
    ],
  ),
  RoomModel(name: 'Kitchen', icon: Icons.kitchen, allDevice: [
    Device(name: 'Smart plug', icon: Icons.power_rounded),
    Device(name: 'Humidity', icon: Icons.opacity)
  ])
];