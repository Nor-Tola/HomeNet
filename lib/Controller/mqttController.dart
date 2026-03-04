import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:mqtt_client/mqtt_client.dart';

import 'package:homecontrol/Model/devices-model.dart';

final mqttDevicesProvider = StateProvider<List<Device>>((ref) => const []);

final mqttServiceProvider = Provider<MqttService>((ref) {
  final svc = MqttService(ref);
  svc.connect(); // start right away
  return svc;
});

class MqttService {
  final Ref ref;
  late final MqttClient _client;
  StreamSubscription? _subscription;

  MqttService(this.ref) {
    _client = MqttClient(
      'test.mosquitto.org',
      'homecontrol_${DateTime.now().millisecondsSinceEpoch}',
    );
    _client.logging(on: false);
    _client.keepAlivePeriod = 20;
    _client.onDisconnected = _onDisconnected;
    _client.onConnected = _onConnected;
    _client.onSubscribed = _onSubscribed;
  }

  Future<void> connect() async {
    try {
      await _client.connect();
      _client.subscribe('home/devices/#', MqttQos.atMostOnce);
      _subscription = _client.updates?.listen(_onMessage);
    } on Exception catch (e) {
      _client.disconnect();
      debugPrint('MQTT connection failed: $e');
    }
  }

  void _onConnected() => debugPrint('mqtt connected');
  void _onDisconnected() => debugPrint('mqtt disconnected');
  void _onSubscribed(String topic) => debugPrint('subscribed to $topic');

  void _onMessage(List<MqttReceivedMessage<MqttMessage>> events) {
    final rec = events.first;
    final payload = (rec.payload as MqttPublishMessage).payload.message;
    final s = utf8.decode(payload);
    final Map<String, dynamic> data = jsonDecode(s);

    // build a Device from the incoming JSON; tweak as needed
    final device = Device(
      id: data['id'] as String,
      name: data['name'] as String,
      icon: _iconForType(data['type'] as String),
      isActive: data['isActive'] as bool? ?? false,
      degree: data['degree'] as int? ?? 0,
    );

    // update the list provider
    final notifier = ref.read(mqttDevicesProvider.notifier);
    final current = notifier.state;
    final idx = current.indexWhere((d) => d.id == device.id);
    if (idx >= 0) {
      current[idx] = device;
      notifier.state = [...current];
    } else {
      notifier.state = [...current, device];
    }
  }

  IconData _iconForType(String type) {
    switch (type) {
      case 'led':
        return Icons.lightbulb;
      case 'fan':
        return Icons.toys;
      default:
        return Icons.device_unknown;
    }
  }

  void dispose() {
    _subscription?.cancel();
    _client.disconnect();
  }
}
