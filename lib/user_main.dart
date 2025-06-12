import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sic_app/custom/bluetooth_device.dart';
import 'package:sic_app/custom/custom_color.dart';
import 'package:sic_app/custom/emergency_state.dart';
import 'package:sic_app/custom/my_user_info.dart';
import 'package:sic_app/custom/personal_info.dart';
import 'package:sic_app/custom/user_key.dart';
import 'package:sic_app/face_scan_tutorial.dart';
import 'package:sic_app/image_picker_screen.dart';
import 'package:sic_app/login_enter_form.dart';
import 'package:sic_app/personal_info_setting.dart';
import 'package:sic_app/setting_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class UserMain extends StatefulWidget {
  const UserMain({super.key});

  @override
  State<UserMain> createState() => _UserMainState();
}

class _UserMainState extends State<UserMain> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: MyColor.white,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
            child: WelcomeText(),
          ),

          Content(
            setAllState: () {
              print("set all state");
              setState(() {});
            },
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.fromBorderSide(
                BorderSide(
                  color: MyColor.black,
                  width: 1.0,
                  strokeAlign: BorderSide.strokeAlignOutside,
                ),
              ),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors:
                    IsStateEmergency.isEmergency
                        ? [MyColor.gray, MyColor.black]
                        : [MyColor.pinkSecondary, MyColor.bluePrimary],
                stops: [0.04, 1.0],
              ),
            ),
            child: Row(children: [SettingButton()]),
          ),
        ],
      ),
    );
  }
}

class Content extends StatelessWidget {
  final Function setAllState;
  const Content({super.key, required this.setAllState});

  @override
  Widget build(BuildContext context) {
    var children = [
      ButtonCard(
        svg: SvgPicture.asset(
          'assets/face_scan_logo.svg',
          width: 100,
          height: 100,
        ),
        button: FaceScanButton(),
        onTap:
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FaceScanTutorialScreen()),
            ),
      ),
      SizedBox(height: 20),
      ButtonCard(
        svg: SvgPicture.asset(
          'assets/bluetooth_logo.svg',
          width: 100,
          height: 100,
        ),
        button: BluetoothButton(),
        onTap: () async {
          print("Bluetooth button tapped");

          late StreamSubscription<BluetoothAdapterState> sub;
          sub = FlutterBluePlus.adapterState.listen((state) {
            print('Bluetooth adapter state: $state');
            Fluttertoast.showToast(
              msg: "$state",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: MyColor.bluePrimary,
              textColor: MyColor.white,
              fontSize: 16.0,
            );
            sub.cancel();
          });
          
          await FlutterBluePlus.turnOn();

          // return;

          print("aldose");
          if (MyBluetoothDevice.device != null) {
            print("disconnecting");
            await MyBluetoothDevice.device!.disconnect();
            MyBluetoothDevice.device = null;
            print("disconnected");
          }
          print("keytose");

          StreamSubscription<List<ScanResult>>
          subscription = FlutterBluePlus.onScanResults.listen(
            (results) async {
              if (results.isEmpty) {
                return;
              }
              var r = results.last;
              if (r.device.advName == "Fall Detector S3") {
                MyBluetoothDevice.device = r.device;
                await MyBluetoothDevice.device!.connect(
                  autoConnect: true,
                  mtu: null,
                );
                late StreamSubscription<BluetoothConnectionState>
                onConnectionState;
                onConnectionState = MyBluetoothDevice.device!.connectionState
                    .listen((state) async {
                      if (state == BluetoothConnectionState.connected) {
                        await onConnectionState.cancel();

                        List<BluetoothService> services =
                            await MyBluetoothDevice.device!.discoverServices();
                        for (var service in services) {
                          for (var characteristic in service.characteristics) {
                            if (characteristic.properties.notify) {
                              MyBluetoothDevice.characteristic = characteristic;
                              characteristic.lastValueStream.listen((value) {
                                String myValue = value.toString();
                                Fluttertoast.showToast(
                                  msg: "Notification Value: $myValue",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: MyColor.bluePrimary,
                                  textColor: MyColor.white,
                                  fontSize: 16.0,
                                );
                              });
                              await characteristic.setNotifyValue(true);
                              Fluttertoast.showToast(
                                msg: "Connected",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: MyColor.bluePrimary,
                                textColor: MyColor.white,
                                fontSize: 16.0,
                              );

                              break;
                            }
                          }
                        }
                      }
                    });
              }
              print('${r.device.advName} found! rssi: ${r.rssi}');
            },
            onError: (e) {
              print("Buddy bluetooth error $e");
            },
          );

          FlutterBluePlus.cancelWhenScanComplete(subscription);

          await FlutterBluePlus.adapterState
              .where((val) => val == BluetoothAdapterState.on)
              .first;

          await FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));

          await FlutterBluePlus.isScanning.where((val) => val == false).first;

          print("buddy finished");
          if (MyBluetoothDevice.device == null) {
            print("Not connected");
            Fluttertoast.showToast(
              msg: "Not Connected",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: MyColor.danger,
              textColor: MyColor.white,
              fontSize: 16.0,
            );
          }
        },
      ),
      SizedBox(height: 20),
      EmergencyButton(setAllState: setAllState),
    ];

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(children: children),
      ),
    );
  }
}

class WelcomeText extends StatefulWidget {
  const WelcomeText({super.key});

  @override
  State<WelcomeText> createState() => _WelcomeTextState();
}

class _WelcomeTextState extends State<WelcomeText> {
  @override
  void initState() {
    super.initState();
    PersonalInfo.cloudPersonalInfoGetter(onUpdate: () => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    // Initialize the non-nullable variable 'username'
    final String nickname =
        PersonalInfo.nickname; // Replace with actual username if available

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 1, color: MyColor.black),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            MyColor.white,
            MyColor.pinkSecondary,
            MyColor.pinkPrimary,
          ],
          stops: [0.72, 0.87, 1.0],

          // tileMode: TileMode.mirror,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              MyColor.bluePrimary,
              MyColor.blueSecondary,
              MyColor.white,
            ],
            stops: [0, 0.11, 0.68],
          ).withOpacity(0.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                IsStateEmergency.isEmergency
                    ? "ฉุกเฉิน! ส่งข้อมูลถึงแพทย์"
                    : 'สวัสดีครับ คุณ$nickname',
                style: TextStyle(fontSize: 24, color: MyColor.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FaceScanButton extends StatelessWidget {
  const FaceScanButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: MyColor.squareColor,
        border: Border.all(color: MyColor.black, width: 1.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Text(
          'กดที่นี่เพื่อสแกนใบหน้าประจำวัน',
          style: TextStyle(fontSize: 24, color: MyColor.black),
        ),
      ),
    );
  }
}

class BluetoothButton extends StatelessWidget {
  const BluetoothButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: MyColor.squareColor,
        border: Border.all(color: MyColor.black, width: 1.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Text(
          'กดที่นี่เพื่อต่อบลูทูธ',
          style: TextStyle(fontSize: 24, color: MyColor.black),
        ),
      ),
    );
  }
}

class EmergencyButton extends StatefulWidget {
  const EmergencyButton({super.key, required this.setAllState});
  final Function setAllState;

  @override
  State<EmergencyButton> createState() => _EmergencyButtonState();
}

class _EmergencyButtonState extends State<EmergencyButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('emergency tapped');
        // Call your onPressed or onTap function here
      },
      child: Container(
        width: 120,
        height: 165,
        child: Center(
          child: Column(
            children: [
              PhoneButton(setAllState: widget.setAllState),
              SizedBox(height: 5),
              Text(
                IsStateEmergency.isEmergency
                    ? "กดเพื่อกลับสู่ปกติ"
                    : "โทร 1669",
                style: TextStyle(fontSize: 24, color: MyColor.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PhoneButton extends StatefulWidget {
  const PhoneButton({super.key, required this.setAllState});
  final Function setAllState;

  @override
  State<PhoneButton> createState() => _PhoneButtonState();
}

class _PhoneButtonState extends State<PhoneButton> {
  late String latitude;
  late String longitude;
  final db = FirebaseFirestore.instance;

  Future<Position> _getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  void callEmergencyNumber() async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: PersonalInfo.emergencyContact,
    ); // Replace with the actual emergency number
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      print('Could not launch dialer');
    }
  }

  Future<void> showEmergencyConfirmationDialog(
    BuildContext context,
    VoidCallback onConfirm,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap a button
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ยืนยันสถานะฉุกเฉิน'),
          content: Text('โปรดยืนยันการเข้าสู่สภาวะฉุกเฉิน'),
          actions: <Widget>[
            TextButton(
              child: Text('ยกเลิก'),
              onPressed: () {
                Navigator.of(context).pop(); // close dialog
              },
            ),
            TextButton(
              child: Text('ยืนยัน', style: TextStyle(color: MyColor.danger)),
              onPressed: () {
                Navigator.of(context).pop(); // close dialog
                onConfirm(); // run confirmation logic
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _getLocation()
            .then((value) {
              latitude = value.latitude.toString();
              longitude = value.longitude.toString();
              // Update the user's position in Firestore
              final position = {"latitude": latitude, "longitude": longitude};
              db
                  .collection("UserInfo")
                  .doc(UserKey.userKey)
                  .set({
                    "Position": position,
                  }, SetOptions(merge: true)) // merge to update existing fields
                  .onError((e, _) => print("Error writing document: $e"));

              print('Latitude: $latitude, Longitude: $longitude');
            })
            .catchError((error) {
              print('Error getting location: $error');
            });
        print('Phone button tapped');
        if (IsStateEmergency.isEmergency == false) {
          showEmergencyConfirmationDialog(context, () {
            setState(() {
              IsStateEmergency.setEmergencyState(isEmergency: true);
              print('State not emergency ---> emergency');
              IsStateEmergency.setCloudEmergencyState(
                onUpdate: () {
                  print('Emergency(true) state updated in Firestore');
                },
              );
              callEmergencyNumber();
              // Call the emergency number // Now enter emergency mode
            });
            widget.setAllState();
          });
        } else {
          IsStateEmergency.setEmergencyState(isEmergency: false);
          print('State emergency ---> not emergency');
          IsStateEmergency.setCloudEmergencyState(
            onUpdate: () {
              print('Emergency(false) state updated in Firestore');
            },
          );
        }

        // Call your onPressed or onTap function here
      },
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: MyColor.danger,
          border: Border.all(color: MyColor.black, width: 1.0),
        ),
        child: Center(
          child: SvgPicture.asset('assets/phone.svg', width: 100, height: 100),
        ),
      ),
    );
  }
}

class SettingButton extends StatelessWidget {
  const SettingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SettingScreen()),
        );
        print('Settings button tapped');
        // Call your onPressed or onTap function here
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/setting_logo.svg',
                width: 40,
                height: 40,
              ),
              SizedBox(width: 10),
              Text(
                'ตั้งค่า',
                style: TextStyle(fontSize: 24, color: MyColor.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonCard extends StatelessWidget {
  final SvgPicture svg;
  final Widget button;
  final void Function()? onTap;

  const ButtonCard({
    super.key,
    required this.svg,
    required this.button,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,

      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 1, color: MyColor.black),
          color: MyColor.bluePrimary,
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: <Color>[
              MyColor.bluePrimary,
              MyColor.blueSecondary,
              MyColor.blueSecondary,
              MyColor.bluePrimary,
            ],
            stops: [0, 0.26, 0.6, 1.0],
            // tileMode: TileMode.mirror,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [svg, SizedBox(height: 10), button],
          ),
        ),
      ),
    );
  }
}
