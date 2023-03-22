import 'dart:async';
import 'dart:convert';
import 'package:flutter_smartclass/services/data_mqtt_services.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttService2 {
  MqttServerClient? client2;
  bool _connected = false;
  late StreamSubscription subscription;
  String temp = 'wait...';

  // static final MqttService2 _singleton = MqttService2._internal();
  // factory MqttService2() => _singleton;
  // MqttService2._internal();

  Future<void> connectAndSubscribe() async {
    if (_connected) {
      return;
    }

    final client = MqttServerClient(
        '104.248.156.51', '${DateTime.now().millisecondsSinceEpoch}');
    client.logging(on: false);
    client.keepAlivePeriod = 20;
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onSubscribed = onSubscribed;
    client.onSubscribeFail = onSubscribeFail;

    final connMessage = MqttConnectMessage()
        .withWillTopic('will-topic')
        .withWillMessage('will')
        .startClean()
        .authenticateAs('ali', '1234')
        .withClientIdentifier('client_id')
        .keepAliveFor(20)
        .withWillQos(MqttQos.atLeastOnce);

    client2 = client;
    client2!.connectionMessage = connMessage;
    await client2!.connect();
  }

  Future<void> sendMessage(String topic, String message) async {
    if (!_connected) {
      return;
    }

    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    client2!.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
  }


  void onConnected() {
    _connected = true;
    client2!.subscribe('Cikunir/lt2/ac2/pzem', MqttQos.atLeastOnce);
    print('connected');
  }

  void onDisconnected() {
    _connected = false;
    print('disconnect');
  }

  void onSubscribed(String topic) {}

  void onSubscribeFail(String topic) {}
}

