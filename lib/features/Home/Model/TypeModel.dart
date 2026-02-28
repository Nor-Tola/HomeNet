import 'package:flutter/material.dart';

class Typemodel {
  IconData icon;
  String name;
  bool isOn;
  Typemodel({required this.icon, required this.name, this.isOn = false});
  Typemodel copyWith({bool? isOn}) {
    return Typemodel(icon: icon, name: name, isOn: isOn ?? this.isOn);
  }
}

List<Typemodel> listType = [
  Typemodel(icon: Icons.bed_outlined, name: "Bedroom"),
  Typemodel(icon: Icons.bathroom_outlined, name: "Bathroom"),
  Typemodel(icon: Icons.living_outlined, name: "Living room"),
  Typemodel(icon: Icons.kitchen_outlined, name: "Kitchen"),
];
