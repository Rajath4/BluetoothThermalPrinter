#import "BluetoothThermalPrinterPlugin.h"
#if __has_include(<bluetooth_thermal_printer/bluetooth_thermal_printer-Swift.h>)
#import <bluetooth_thermal_printer/bluetooth_thermal_printer-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "bluetooth_thermal_printer-Swift.h"
#endif

@implementation BluetoothThermalPrinterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftBluetoothThermalPrinterPlugin registerWithRegistrar:registrar];
}
@end
