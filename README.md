# bluetooth_thermal_printer

[![Pub Version](https://img.shields.io/pub/v/bluetooth_thermal_printer)](https://pub.dev/packages/bluetooth_thermal_printer)

The library allows printing receipts using a Bluetooth printer(Android Only).  It supports both 58mm and 80mm Bluetooth printers. 

This package does not use Location Permission. By that, it follows google's policy of Android 10.

## Add-ons
1. [esc_pos_utils](https://pub.dev/packages/esc_pos_utils) package to print receipts 
2. [Image](https://pub.dev/packages/image) to print images


### Simple Ticket with Styles:
```dart
Ticket testTicket() {
  final Ticket ticket = Ticket(PaperSize.mm80);

  ticket.text(
      'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
  ticket.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ',
      styles: PosStyles(codeTable: PosCodeTable.westEur));
  ticket.text('Special 2: blåbærgrød',
      styles: PosStyles(codeTable: PosCodeTable.westEur));

  ticket.text('Bold text', styles: PosStyles(bold: true));
  ticket.text('Reverse text', styles: PosStyles(reverse: true));
  ticket.text('Underlined text',
      styles: PosStyles(underline: true), linesAfter: 1);
  ticket.text('Align left', styles: PosStyles(align: PosAlign.left));
  ticket.text('Align center', styles: PosStyles(align: PosAlign.center));
  ticket.text('Align right',
      styles: PosStyles(align: PosAlign.right), linesAfter: 1);

  ticket.text('Text size 200%',
      styles: PosStyles(
        height: PosTextSize.size2,
        width: PosTextSize.size2,
      ));

  ticket.feed(2);
  ticket.cut();
  return ticket;
}
```

You can find more examples here: [esc_pos_utils](https://github.com/andrey-ushakov/esc_pos_utils).

## How to Help
* Test your printer and add it in the table: [Tested Printers](printers.md)
* Test and report bugs
* Share your ideas about what could be improved (code optimization, new features...)
* PRs are welcomed!


## Tested Printers
Here are some [printers tested with this library](printers.md). Please add the models you have tested to maintain and improve this library and help others to choose the right printer.

For a complete example, check the [example project](example/).

## Test Print
<img src="https://raw.githubusercontent.com/Rajath4/BluetoothThermalPrinter/master/demo1.jpg" alt="test receipt" width="400"/>

<img src="https://raw.githubusercontent.com/Rajath4/BluetoothThermalPrinter/master/demo2.jpg" alt="test receipt" width="400"/>