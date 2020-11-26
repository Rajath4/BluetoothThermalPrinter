import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bluetooth_thermal_printer/bluetooth_thermal_printer.dart';

void main() {
  const MethodChannel channel = MethodChannel('bluetooth_thermal_printer');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await BluetoothThermalPrinter.platformVersion, '42');
  });
}
