import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sic_app/custom/custom_color.dart';
import 'package:sic_app/doctor_main.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DoctorDanger extends StatelessWidget {
  const DoctorDanger({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
            colors: <Color>[
              MyColor.pinkSecondary,
              MyColor.white,
              MyColor.white,
              MyColor.pinkPrimary,
            ],
            stops: [0, 0.38, 0.56, 1],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              StatusText(),
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: MyColor.black),
                    color: MyColor.white,
                  ),
                  child: Column(
                    children: [
                      const Heading(),
                      Expanded(child: DangerPatientList()),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  BackButton(),ToMain(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class StatusText extends StatelessWidget {
  const StatusText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 1, color: MyColor.black),
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: <Color>[
                  MyColor.pinkPrimary,
                  MyColor.pinkSecondary,
                  MyColor.white,
                ],
                stops: [0, 0.32, 0.91],

                // tileMode: TileMode.mirror,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text(
                'Danger Danger Danger',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: MyColor.black),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Heading extends StatelessWidget {
  const Heading({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[MyColor.pinkPrimary, MyColor.pinkSecondary],
                stops: [0, 1],
              ),
              border: Border(
                bottom: BorderSide(color: MyColor.black, width: 1),
              ), // Border.all
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  "รายชื่อคนไข้",
                  style: const TextStyle(fontSize: 20, color: MyColor.black),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DangerPatientcard extends StatelessWidget {
  final String patientName;
  final String patientSurName;
  final String patientNote1;
  final String patientNote2;
  final String patientNote3;
  final String phoneNumber;
  final String emergencyContact;
  final String latitude;
  final String longitude;

  const DangerPatientcard({
    super.key,
    required this.patientName,
    required this.patientSurName,
    required this.patientNote1,
    required this.patientNote2,
    required this.patientNote3,
    required this.phoneNumber,
    required this.emergencyContact,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: MyColor.black),
        color: MyColor.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // blue header
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              border: Border(
                bottom: BorderSide(color: MyColor.black, width: 1),
                right: BorderSide(color: MyColor.black, width: 1),
              ),
              color: MyColor.white,
            ),
            padding: const EdgeInsets.all(10),
            child: Text(
              'คุณ $patientName $patientSurName',
              style: TextStyle(
                fontSize: 20,
                color: MyColor.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // notes
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
            child: Text(
              'Note: $patientNote1, $patientNote2, $patientNote3',
              style: TextStyle(fontSize: 18, color: MyColor.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
            child: Text(
              'Contact: $phoneNumber',
              style: TextStyle(fontSize: 18, color: MyColor.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
            child: Text(
              'Emergency contact: $emergencyContact',
              style: TextStyle(fontSize: 18, color: MyColor.black),
            ),
          ),
          MapButton(latitude: latitude, longitude: longitude),
        ],
      ),
    );
  }
}

class DangerPatientList extends StatelessWidget {
  const DangerPatientList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance
              .collection('UserInfo')
              .where('EmergencyState', isEqualTo: true)
              .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Error loading data'));
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final docs = snapshot.data!.docs;

        return ListView.builder(
          itemCount: docs.length,
          padding: const EdgeInsets.only(bottom: 12),
          itemBuilder: (context, index) {
            final data = docs[index].data() as Map<String, dynamic>;
            final personal = (data['PersonalInfo'] as Map?) ?? {};
            final health = (data['HealthInfo'] as Map?) ?? {};
            final phoneNumber = (data['PhoneNumber'] as String?) ?? '-';
            final location = (data['Position'] as Map?) ?? {};

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              child: DangerPatientcard(
                patientName: personal['name'] ?? '',
                patientSurName: personal['surname'] ?? '',
                patientNote1: health['riskFactor1'] ?? '-',
                patientNote2: health['riskFactor2'] ?? '-',
                patientNote3: health['riskFactor3'] ?? '-',
                phoneNumber: phoneNumber,
                emergencyContact: personal['emergencyContact'] ?? '-',
                latitude: location['latitude']?.toString() ?? '0.0',
                longitude: location['longitude']?.toString() ?? '0.0',
              ),
            );
          },
        );
      },
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
            // Call your onPressed or onTap function here
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[MyColor.bluePrimary, MyColor.white],
                stops: [0, 1],
              ),
              border: Border.all(
                color: MyColor.black,
                width: 1.0,
              ), // Border.all),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text("ออกจากระบบ", style: TextStyle(fontSize: 20)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MapButton extends StatefulWidget {
  String latitude = '';
  String longitude = '';
  MapButton({super.key, required this.latitude, required this.longitude});

  @override
  State<MapButton> createState() => _MapButtonState();
}

class _MapButtonState extends State<MapButton> {
  Future<void> _openmap(String latitude, String longitude) async {
    String url =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    print('Opening map with URL: $url');
    await launchUrlString(url);
    // if (await canLaunchUrlString(url)) {
    //     await launchUrlString(url);
    // } else {
    //     throw 'Could not launch $url';
    // }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _openmap(widget.latitude, widget.longitude);
        // Call your onPressed or onTap function here
      },
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: MyColor.white,
                border: Border.all(color: MyColor.danger, width: 3.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset(
                      'assets/map.svg',
                      width: 100,
                      height: 100,
                    ),
                  ),
                  const Text(
                    'Map',
                    style: TextStyle(fontSize: 20, color: MyColor.danger),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ToMain extends StatelessWidget {
  const ToMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const DoctorMain()));
            // Call your onPressed or onTap function here
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[MyColor.blueSecondary, MyColor.pinkPrimary],
                stops: [0, 1],
              ),
              border: Border.all(
                color: MyColor.black,
                width: 1.0,
              ), // Border.all),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text("ดูรายชื่อคนไข้", style: TextStyle(fontSize: 20)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}