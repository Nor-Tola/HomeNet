import 'package:flutter/material.dart';

class Device {
  final String id; // ✅ unique id
  final String name;
  final IconData icon;
  final bool isActive;
  final int degree;

  Device({
    required this.id,
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
      id: id,
      name: name,
      icon: icon,
      isActive: isActive ?? this.isActive,
      degree: degree ?? this.degree,
    );
  }
}