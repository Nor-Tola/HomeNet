import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

final themeProvider = StateProvider<ThemeData>((ref)=>ThemeData.light());