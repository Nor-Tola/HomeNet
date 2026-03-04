import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homecontrol/Controller/ThemeController.dart';
import 'package:homecontrol/Controller/mqttController.dart';
import 'package:homecontrol/features/Auth/presentation/Screen/login_screen.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(themeProvider);
    ref.watch(mqttServiceProvider);
    return MaterialApp(
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
      theme: value,
    );
  }
}
