import 'dart:async';

import 'package:bluetooth_thermal_printer/bluetooth_thermal_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  bool connected = false;
  List availableBluetoothDevices = new List();

  Future<void> getBluetooth() async {
    final List bluetooths = await BluetoothThermalPrinter.getBluetooths;
    print("Print $bluetooths");
    setState(() {
      availableBluetoothDevices = bluetooths;
    });
  }

  Future<void> setConnect(String mac) async {
    final String result = await BluetoothThermalPrinter.connect(mac);
    print("state conneected $result");
    if (result == "true") {
      setState(() {
        connected = true;
      });
    }
  }

  Future<void> printTicket() async {
    String isConnected = await BluetoothThermalPrinter.connectionStatus;
    if (isConnected == "true") {
      Ticket ticket = await getTicket();
      final result = await BluetoothThermalPrinter.writeBytes(ticket.bytes);
      print("Print $result");
    } else {
      //Hadnle Not Connected Senario
    }
  }

  Future<void> printGraphics() async {
    String isConnected = await BluetoothThermalPrinter.connectionStatus;
    if (isConnected == "true") {
      Ticket ticket = await getGraphicsTicket();
      final result = await BluetoothThermalPrinter.writeBytes(ticket.bytes);
      print("Print $result");
    } else {
      //Hadnle Not Connected Senario
    }
  }

  Future<Ticket> getGraphicsTicket() async {
    CapabilityProfile profile = await CapabilityProfile.load();
    final Ticket ticket = Ticket(PaperSize.mm80, profile);

    // Print QR Code using native function
    ticket.qrcode('example.com');

    ticket.hr();

    // Print Barcode using native function
    final List<int> barData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 4];
    ticket.barcode(Barcode.upcA(barData));

    ticket.cut();

    return ticket;
  }

  Future<Ticket> getTicket() async {
    CapabilityProfile profile = await CapabilityProfile.load();
    final Ticket ticket = Ticket(PaperSize.mm80, profile);
    ticket.text("Demo Shop",
        styles: PosStyles(
          align: PosAlign.center,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
        linesAfter: 1);

    ticket.text(
        "18th Main Road, 2nd Phase, J. P. Nagar, Bengaluru, Karnataka 560078",
        styles: PosStyles(align: PosAlign.center));
    ticket.text('Tel: +919591708470',
        styles: PosStyles(align: PosAlign.center));

    ticket.hr();
    ticket.row([
      PosColumn(
          text: 'No',
          width: 1,
          styles: PosStyles(align: PosAlign.left, bold: true)),
      PosColumn(
          text: 'Item',
          width: 5,
          styles: PosStyles(align: PosAlign.left, bold: true)),
      PosColumn(
          text: 'Price',
          width: 2,
          styles: PosStyles(align: PosAlign.center, bold: true)),
      PosColumn(
          text: 'Qty',
          width: 2,
          styles: PosStyles(align: PosAlign.center, bold: true)),
      PosColumn(
          text: 'Total',
          width: 2,
          styles: PosStyles(align: PosAlign.right, bold: true)),
    ]);

    ticket.row([
      PosColumn(text: "1", width: 1),
      PosColumn(
          text: "Tea",
          width: 5,
          styles: PosStyles(
            align: PosAlign.left,
          )),
      PosColumn(
          text: "10",
          width: 2,
          styles: PosStyles(
            align: PosAlign.center,
          )),
      PosColumn(text: "1", width: 2, styles: PosStyles(align: PosAlign.center)),
      PosColumn(text: "10", width: 2, styles: PosStyles(align: PosAlign.right)),
    ]);

    ticket.row([
      PosColumn(text: "2", width: 1),
      PosColumn(
          text: "Sada Dosa",
          width: 5,
          styles: PosStyles(
            align: PosAlign.left,
          )),
      PosColumn(
          text: "30",
          width: 2,
          styles: PosStyles(
            align: PosAlign.center,
          )),
      PosColumn(text: "1", width: 2, styles: PosStyles(align: PosAlign.center)),
      PosColumn(text: "30", width: 2, styles: PosStyles(align: PosAlign.right)),
    ]);

    ticket.row([
      PosColumn(text: "3", width: 1),
      PosColumn(
          text: "Masala Dosa",
          width: 5,
          styles: PosStyles(
            align: PosAlign.left,
          )),
      PosColumn(
          text: "50",
          width: 2,
          styles: PosStyles(
            align: PosAlign.center,
          )),
      PosColumn(text: "1", width: 2, styles: PosStyles(align: PosAlign.center)),
      PosColumn(text: "50", width: 2, styles: PosStyles(align: PosAlign.right)),
    ]);

    ticket.row([
      PosColumn(text: "4", width: 1),
      PosColumn(
          text: "Rova Dosa",
          width: 5,
          styles: PosStyles(
            align: PosAlign.left,
          )),
      PosColumn(
          text: "70",
          width: 2,
          styles: PosStyles(
            align: PosAlign.center,
          )),
      PosColumn(text: "1", width: 2, styles: PosStyles(align: PosAlign.center)),
      PosColumn(text: "70", width: 2, styles: PosStyles(align: PosAlign.right)),
    ]);

    ticket.hr();

    ticket.row([
      PosColumn(
          text: 'TOTAL',
          width: 6,
          styles: PosStyles(
            align: PosAlign.left,
            height: PosTextSize.size4,
            width: PosTextSize.size4,
          )),
      PosColumn(
          text: "160",
          width: 6,
          styles: PosStyles(
            align: PosAlign.right,
            height: PosTextSize.size4,
            width: PosTextSize.size4,
          )),
    ]);

    ticket.hr(ch: '=', linesAfter: 1);

    // ticket.feed(2);
    ticket.text('Thank you!',
        styles: PosStyles(align: PosAlign.center, bold: true));

    ticket.text("26-11-2020 15:22:45",
        styles: PosStyles(align: PosAlign.center), linesAfter: 1);

    ticket.text('Note: Goods once sold will not be taken back or exchanged.',
        styles: PosStyles(align: PosAlign.center, bold: false));
    ticket.cut();
    return ticket;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Bluetooth Thermal Printer Demo'),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Search Paired Bluetooth"),
              OutlineButton(
                onPressed: () {
                  this.getBluetooth();
                },
                child: Text("Search"),
              ),
              Container(
                height: 200,
                child: ListView.builder(
                  itemCount: availableBluetoothDevices.length > 0
                      ? availableBluetoothDevices.length
                      : 0,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        String select = availableBluetoothDevices[index];
                        List list = select.split("#");
                        String name = list[0];
                        String mac = list[1];
                        this.setConnect(mac);
                      },
                      title: Text('${availableBluetoothDevices[index]}'),
                      subtitle: Text("Click to connect"),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              OutlineButton(
                onPressed: connected ? this.printGraphics : null,
                child: Text("Print"),
              ),
              OutlineButton(
                onPressed: connected ? this.printTicket : null,
                child: Text("Print Ticket"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
