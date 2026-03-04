import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:homecontrol/Model/TypeModel.dart';

final typeProvider = StateProvider<List<Typemodel>>((ref) {
  return [
    Typemodel(icon: Icons.light, name: "Light"),
    Typemodel(icon: Icons.air, name: 'Air')
  ];
});