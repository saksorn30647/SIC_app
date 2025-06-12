import 'dart:async';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:sic_app/custom/bluetooth_device.dart';
import 'package:sic_app/custom/custom_color.dart';
import 'package:sic_app/face_scan_tutorial.dart';

class BluetoothDiscoverScreen extends StatefulWidget {
  const BluetoothDiscoverScreen({super.key});

  @override
  State<BluetoothDiscoverScreen> createState() =>
      _BluetoothDiscoverScreenState();
}

class _BluetoothDiscoverScreenState extends State<BluetoothDiscoverScreen> {
  String text = "Bluetooth Discover Screen";
  bool bluetoothState = false;
  late StreamSubscription<BluetoothAdapterState> adapterStateSubscription;
  late StreamSubscription<BluetoothConnectionState> connectionStateSubscription;

  @override
  void initState() {
    super.initState();
    // Initialize Bluetooth state
    adapterStateSubscription = FlutterBluePlus.adapterState.listen((
      BluetoothAdapterState state,
    ) {
      print(state);
      if (state == BluetoothAdapterState.on) {
        text = "Bluetooth is ON";
        bluetoothState = true;
      } else {
        text = "Bluetooth is OFF";
        bluetoothState = false;
      }
      setState(() {}); // Update UI
    });

    if (!kIsWeb && Platform.isAndroid) {
      FlutterBluePlus.turnOn();
      print("hello");
    }
  }

  @override
  void dispose() {
    // Clean up resources
    adapterStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(text),
            ElevatedButton(
              onPressed: () async {
                FlutterBluePlus.adapterState.listen((state) {
                  print("Bluetooth adapter state: $state");
                });

                var subscription = FlutterBluePlus.onScanResults.listen((
                  results,
                ) async {
                  if (results.isNotEmpty) {
                    ScanResult r = results.last;
                    print("found device: ${r.device.advName}");

                    if (r.device.advName == "Fall Detector S3") {
                      MyBluetoothDevice.device = r.device;
                      await MyBluetoothDevice.device!.connect(
                        autoConnect: true,
                        mtu: null,
                      );

                      connectionStateSubscription = MyBluetoothDevice
                          .device!
                          .connectionState
                          .listen((BluetoothConnectionState state) async {
                            print("Buddy $state");
                            if (state !=
                                BluetoothConnectionState.disconnected) {
                              List<BluetoothService> services =
                                  await MyBluetoothDevice.device!
                                      .discoverServices();
                              services.forEach((service) async {
                                var characteristics = service.characteristics;
                                for (BluetoothCharacteristic c
                                    in characteristics) {
                                  if (c.properties.read) {
                                    List<int> value = await c.read();
                                    print(value);
                                  }

                                  if (c.properties.notify) {
                                    c.lastValueStream.listen((value) {
                                      print("Notification value: $value");
                                      String myValue = value.toString();
                                      Fluttertoast.showToast(
                                        msg: "Notification Value: $myValue",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: MyColor.bluePrimary,
                                        textColor: MyColor.white,
                                        fontSize: 16.0,
                                      );
                                      if (myValue[0] == "1") {
                                        showDialog(
                                          context: context,
                                          barrierDismissible:
                                              false, // user must tap a button
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('ยืนยันสถานะฉุกเฉิน'),
                                              content: Text(
                                                'โปรดยืนยันการเข้าสู่สภาวะฉุกเฉิน',
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: Text('ยืนยัน'),
                                                  onPressed: () {
                                                    print("ยืนยัน");
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: Text('ยกเลิก'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    });
                                    await c.setNotifyValue(true);
                                  }

                                  if (!(c.properties.write &&
                                      c.properties.read)) {
                                    return;
                                  }

                                  // if (c.uuid.toString() ==
                                  //     "beb5483e-36e1-4688-b7f5-ea07361b26a8") {
                                  //   myChar = c;
                                  //   // Example of writing to a characteristic
                                  //   await c.write([0x01, 0x02, 0x03]);
                                  //   print("Characteristic written");
                                  // }
                                }
                              });
                            }
                          });

                      MyBluetoothDevice.device!.cancelWhenDisconnected(
                        connectionStateSubscription,
                        delayed: true,
                        next: true,
                      );
                    }
                  } else {
                    print("No devices found");
                  }
                }, onError: (e) => print(e));

                FlutterBluePlus.cancelWhenScanComplete(subscription);
                await FlutterBluePlus.adapterState
                    .where((val) => val == BluetoothAdapterState.on)
                    .first;

                await FlutterBluePlus.startScan(
                  timeout: const Duration(seconds: 5),
                );

                await FlutterBluePlus.isScanning
                    .where((val) => val == false)
                    .first;
              },
              child: const Text("scan bluetooth devices"),
            ),
            ElevatedButton(
              onPressed: () async {},
              child: const Text("stop scan"),
            ),
            ElevatedButton(
              onPressed: () {
                if (MyBluetoothDevice.device == null) {
                  print("No device connected");
                  return;
                }
                MyBluetoothDevice.device!.disconnect();
              },
              child: const Text("Disconnect"),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false, // user must tap a button
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('ยืนยันสถานะฉุกเฉิน'),
                      content: Text('โปรดยืนยันการเข้าสู่สภาวะฉุกเฉิน'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('ยืนยัน'),
                          onPressed: () {
                            print("ยืนยัน");
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text('ยกเลิก'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text("Read Characteristic"),
            ),
          ],
        ),
      ),
    );
  }
}
