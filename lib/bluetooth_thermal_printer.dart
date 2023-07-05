import 'dart:async';

import 'package:flutter/services.dart';

class BluetoothThermalPrinter {
  static const MethodChannel _channel =
      const MethodChannel('bluetooth_thermal_printer');

  /// Get android platform version.
  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  /// Get list of all paired bluetooth devices
  static Future<List?> get getBluetooths async {
    List? items = [];
    try {
      final List? result = await _channel.invokeMethod('bluetothLinked');
      items = result;
    } on PlatformException catch (e) {
      print("Bluetooth paired failure: '${e.message}'.");
    }

    return items;
  }

  /// Get bluetooth device connection status
  static Future<String?> get connectionStatus async {
    try {
      final String? result = await _channel.invokeMethod('connectionStatus');
      return result;
    } on PlatformException catch (e) {
      print("Failed to write bytes: '${e.message}'.");
      return "false";
    }
  }

  /// Connect to device using [mac].
  static Future<String?> connect(String mac) async {
    String? result = "false";
    try {
      result = await _channel.invokeMethod('connectPrinter', mac);
    } on PlatformException catch (e) {
      print("Failed to connect: '${e.message}'.");
    }
    return result;
  }
  // disconnect to any connected device                        --> new feature
  static Future<String?> disconnect() async {
    String? result = "false";
    try {
      result = await _channel.invokeMethod('disconnectPrinter');
    } on PlatformException catch (e) {
      print("Failed to disconnect: '${e.message}'.");
    }
    return result;
  }


  ///Printes the [bytes] using bluetooth printer.
  static Future<String?> writeBytes(List<int> bytes) async {
    try {
      final String? result = await _channel.invokeMethod('writeBytes', bytes);
      return result;
    } on PlatformException catch (e) {
      print("Failed to write bytes: '${e.message}'.");
      return "false";
    }
  }

  ///Printes the [text] using bluetooth printer.
  static Future<String?> writeText(String text) async {
    try {
      final String? result = await _channel.invokeMethod('printText', text);
      return result;
    } on PlatformException catch (e) {
      print("Failed to writeText: '${e.message}'.");
      return "false";
    }
  }

  /// Get battery level of the android device.
  static Future<int?> get getBatteryLevel async {
    try {
      final int? result = await _channel.invokeMethod('getBatteryLevel');
      return result;
    } on PlatformException catch (e) {
      print("Failed to get battery level: '${e.message}'.");
      return -1;
    }
  }
}
