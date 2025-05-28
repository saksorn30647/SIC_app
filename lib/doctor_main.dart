import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sic_app/custom/custom_color.dart';
import 'package:sic_app/doctor_danger.dart';

// class DoctorMain extends StatefulWidget {
//   const DoctorMain({super.key});

//   @override
//   _DoctorMainState createState() => _DoctorMainState();
// }

// class _DoctorMainState extends State<DoctorMain> {
//   final Stream<QuerySnapshot> _usersStream =
//       FirebaseFirestore.instance.collection('UserInfo').snapshots();

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: _usersStream,
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return const Text('Something went wrong');
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Text("Loading");
//         }

//         return Material(
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomRight,
//             colors: <Color>[MyColor.blueSecondary,MyColor.white,MyColor.white, MyColor.bluePrimary],
//             stops: [0, 0.38,0.56,1],
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               StatusText(),
//               const SizedBox(height: 20),
//               Expanded(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     border: Border.all(color: MyColor.black),
//                     color: MyColor.white,
//                   ),
//                   child: Column(
//                     children: [const Heading(), Expanded(child: PatientList())],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               BackButton(),
//             ],
//           ),
//         ),
//       ),
//     );
//       },
//     );
//   }
// }

class DoctorMain extends StatelessWidget {
  const DoctorMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
            colors: <Color>[MyColor.blueSecondary,MyColor.white,MyColor.white, MyColor.bluePrimary],
            stops: [0, 0.38,0.56,1],
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
                    children: [const Heading(), Expanded(child: PatientList())],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackButton(),ToDanger(),
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
                'Everyone is having a good day!',
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
                colors: <Color>[MyColor.bluePrimary, MyColor.blueSecondary],
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

class PatientDatacardTemplate extends StatelessWidget {
  final String patientName;
  final String patientSurName;
  final String patientNote1;
  final String patientNote2;
  final String patientNote3;
  final String phoneNumber;

  const PatientDatacardTemplate({
    super.key,
    required this.patientName,
    required this.patientSurName,
    required this.patientNote1,
    required this.patientNote2,
    required this.patientNote3,
    required this.phoneNumber,
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
              color: MyColor.blueSecondary,
            ),
            padding: const EdgeInsets.all(10),
            child: Text(
              'คุณ $patientName $patientSurName',
              style: TextStyle(fontSize: 20, color: MyColor.black),
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
        ],
      ),
    );
  }
}

class PatientList extends StatelessWidget {
  const PatientList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('UserInfo').snapshots(),
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

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              child: PatientDatacardTemplate(
                patientName: personal['name'] ?? '',
                patientSurName: personal['surname'] ?? '',
                patientNote1: health['riskFactor1'] ?? '-',
                patientNote2: health['riskFactor2'] ?? '-',
                patientNote3: health['riskFactor3'] ?? '-',
                phoneNumber: phoneNumber,
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
                colors: <Color>[
                  MyColor.bluePrimary,
                  MyColor.white,
                ],
                stops: [0, 1],
              ),
              border: Border.all(color: MyColor.black, width: 1.0), // Border.all),
            ),
            child: Center(child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text("ออกจากระบบ", style: TextStyle(fontSize: 20)),
            )),
          ),
        ),
      ],
    );
  }
}

class ToDanger extends StatelessWidget {
  const ToDanger({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            Navigator.pushReplacement(context ,
                MaterialPageRoute(builder: (context) => DoctorDanger()));
            // Call your onPressed or onTap function here
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[MyColor.pinkPrimary, MyColor.white],
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
                child: Text("ดูคนไข้ฉุกเฉิน", style: TextStyle(fontSize: 20)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}