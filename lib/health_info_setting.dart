import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sic_app/components/health_info_format.dart';
import 'package:sic_app/components/number_type_box.dart';
import 'package:sic_app/custom/custom_color.dart';
import 'package:sic_app/custom/health_info.dart';
import 'package:sic_app/custom/user_key.dart';
import 'package:sic_app/user_main.dart';

class HealthInfoSetting extends StatelessWidget {
  const HealthInfoSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: <Color>[
              MyColor.blueSecondary,
              MyColor.white,
              MyColor.bluePrimary,
            ],
            stops: [0, 0.5, 1],
            // tileMode: TileMode.mirror,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Center(
            child: Container(
              
              decoration:  BoxDecoration(
                color: MyColor.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(color: MyColor.black, width: 1.0),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Header(),
                  Expanded(child: ScrollableContainer()),
                  ButtonPanel(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Heading(),
              SizedBox(height: 17),
              Text(
                "**การตั้งค่าข้อมูลสุขภาพควรทำโดยผู้มีความรู้เช่น แพทย์และพยาบาล",
                style: TextStyle(fontSize: 12, color: MyColor.green),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Heading extends StatelessWidget {
  const Heading({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: MyColor.bluePrimary,
              border: Border(
                bottom: BorderSide(color: MyColor.black, width: 1),
              ), // Border.all
            ),
            child: Center(
              child: Text(
                "ตั้งค่าข้อมูลสุขภาพ",
                style: const TextStyle(fontSize: 20, color: MyColor.black),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BloodPressureRow extends StatelessWidget {
  const BloodPressureRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "ความดันโลหิต :",
          style: TextStyle(fontSize: 20, color: MyColor.black),
        ),
        NumberTypeBox(
          textController: ControllerController.sysbloodpressureController,
          hintText: "Sys",
        ),
        SizedBox(width: 10),

        NumberTypeBox(
          textController: ControllerController.diabloodpressureController,
          hintText: "Dia",
        ),
      ],
    );
  }
}

class ScrollableContainer extends StatelessWidget {
  const ScrollableContainer({super.key});

  @override
  Widget build(BuildContext context) {
    var children = [
      BloodPressureRow(),
      SizedBox(height: 10),
      ChronicDisease(),

      SizedBox(height: 10),
      MedicineHistory(),

      SizedBox(height: 10),
      MedicineAllergic(),
      SizedBox(height: 10),
      MedicalHistory(),

      SizedBox(height: 10),
      RiskFactor(),
    ];
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(children: children),
    );
  }
}

class RiskFactor extends StatelessWidget {
  const RiskFactor({super.key});

  @override
  Widget build(BuildContext context) {
    return HealthInfoFormat(
      textController1: ControllerController.riskFactorsController1,
      textController2: ControllerController.riskFactorsController2,
      textController3: ControllerController.riskFactorsController3,
      title: "ปัจจัยเสี่ยง :",
      hintText1: "ปัจจัยเสี่ยง 1",
      hintText2: "ปัจจัยเสี่ยง 2",
      hintText3: "ปัจจัยเสี่ยง 3",
    );
  }
}

class ChronicDisease extends StatelessWidget {
  const ChronicDisease({super.key});

  @override
  Widget build(BuildContext context) {
    return HealthInfoFormat(
      textController1: ControllerController.chronicDiseaseController1,
      textController2: ControllerController.chronicDiseaseController2,
      textController3: ControllerController.chronicDiseaseController3,
      title: "โรคประจำตัว :",
      hintText1: "โรคประจำตัว 1",
      hintText2: "โรคประจำตัว 2",
      hintText3: "โรคประจำตัว 3",
    );
  }
}

class MedicineHistory extends StatelessWidget {
  const MedicineHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return HealthInfoFormat(
      textController1: ControllerController.medicineHistoryController1,
      textController2: ControllerController.medicineHistoryController2,
      textController3: ControllerController.medicineHistoryController3,
      title: "ประวัติการใช้ยา :",
      hintText1: "ประวัติการใช้ยา 1",
      hintText2: "ประวัติการใช้ยา 2",
      hintText3: "ประวัติการใช้ยา 3",
    );
  }
}

class MedicineAllergic extends StatelessWidget {
  const MedicineAllergic({super.key});

  @override
  Widget build(BuildContext context) {
    return HealthInfoFormat(
      textController1: ControllerController.medicineAllergicController1,
      textController2: ControllerController.medicineAllergicController2,
      textController3: ControllerController.medicineAllergicController3,
      title: "ประวัติการแพ้ยา :",
      hintText1: "ประวัติการแพ้ยา 1",
      hintText2: "ประวัติการแพ้ยา 2",
      hintText3: "ประวัติการแพ้ยา 3",
    );
  }
}

class MedicalHistory extends StatelessWidget {
  const MedicalHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return HealthInfoFormat(
      textController1: ControllerController.medicalRecordController1,
      textController2: ControllerController.medicalRecordController2,
      textController3: ControllerController.medicalRecordController3,
      title: "ประวัติการรักษา :",
      hintText1: "ประวัติการรักษา 1",
      hintText2: "ประวัติการรักษา 2",
      hintText3: "ประวัติการรักษา 3",
    );
  }
}

class ControllerController {
  static final TextEditingController sysbloodpressureController =
      TextEditingController();
  static final TextEditingController diabloodpressureController =
      TextEditingController();
  static final TextEditingController chronicDiseaseController1 =
      TextEditingController();
  static final TextEditingController chronicDiseaseController2 =
      TextEditingController();
  static final TextEditingController chronicDiseaseController3 =
      TextEditingController();
  static final TextEditingController medicineHistoryController1 =
      TextEditingController();
  static final TextEditingController medicineHistoryController2 =
      TextEditingController();
  static final TextEditingController medicineHistoryController3 =
      TextEditingController();
  static final TextEditingController medicineAllergicController1 =
      TextEditingController();
  static final TextEditingController medicineAllergicController2 =
      TextEditingController();
  static final TextEditingController medicineAllergicController3 =
      TextEditingController();
  static final TextEditingController medicalRecordController1 =
      TextEditingController();
  static final TextEditingController medicalRecordController2 =
      TextEditingController();
  static final TextEditingController medicalRecordController3 =
      TextEditingController();
  static final TextEditingController riskFactorsController1 =
      TextEditingController();
  static final TextEditingController riskFactorsController2 =
      TextEditingController();
  static final TextEditingController riskFactorsController3 =
      TextEditingController();
}

class ButtonPanel extends StatelessWidget {
  const ButtonPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Container(
        decoration: BoxDecoration(color: MyColor.white.withAlpha(128)),
        height: 60,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BackButton(),
            SizedBox(width: 5),
            AcceptButton(
              sysbloodpressureController:
                  ControllerController.sysbloodpressureController,
              diabloodpressureController:
                  ControllerController.diabloodpressureController,
              chronicDiseaseController1:
                  ControllerController.chronicDiseaseController1,
              chronicDiseaseController2:
                  ControllerController.chronicDiseaseController2,
              chronicDiseaseController3:
                  ControllerController.chronicDiseaseController3,
              medicineHistoryController1:
                  ControllerController.medicineHistoryController1,
              medicineHistoryController2:
                  ControllerController.medicineHistoryController2,
              medicineHistoryController3:
                  ControllerController.medicineHistoryController3,
              medicineAllergicController1:
                  ControllerController.medicineAllergicController1,
              medicineAllergicController2:
                  ControllerController.medicineAllergicController2,
              medicineAllergicController3:
                  ControllerController.medicineAllergicController3,
              medicalRecordController1:
                  ControllerController.medicalRecordController1,
              medicalRecordController2:
                  ControllerController.medicalRecordController2,
              medicalRecordController3:
                  ControllerController.medicalRecordController3,
              riskFactorsController1:
                  ControllerController.riskFactorsController1,
              riskFactorsController2:
                  ControllerController.riskFactorsController2,
              riskFactorsController3:
                  ControllerController.riskFactorsController3,
            ),
          ],
        ),
      ),
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        // Call your onPressed or onTap function here
      },
      child: Container(
        width: 150,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: MyColor.white,
          border: Border.all(color: MyColor.black, width: 1.0), // Border.all),
        ),
        child: Center(child: Text("ย้อนกลับ", style: TextStyle(fontSize: 20))),
      ),
    );
  }
}

class AcceptButton extends StatefulWidget {
  final TextEditingController sysbloodpressureController;
  final TextEditingController diabloodpressureController;
  final TextEditingController chronicDiseaseController1;
  final TextEditingController chronicDiseaseController2;
  final TextEditingController chronicDiseaseController3;
  final TextEditingController medicineHistoryController1;
  final TextEditingController medicineHistoryController2;
  final TextEditingController medicineHistoryController3;
  final TextEditingController medicineAllergicController1;
  final TextEditingController medicineAllergicController2;
  final TextEditingController medicineAllergicController3;
  final TextEditingController medicalRecordController1;
  final TextEditingController medicalRecordController2;
  final TextEditingController medicalRecordController3;
  final TextEditingController riskFactorsController1;
  final TextEditingController riskFactorsController2;
  final TextEditingController riskFactorsController3;

  AcceptButton({
    super.key,
    required this.sysbloodpressureController,
    required this.diabloodpressureController,
    required this.chronicDiseaseController1,
    required this.chronicDiseaseController2,
    required this.chronicDiseaseController3,
    required this.medicineHistoryController1,
    required this.medicineHistoryController2,
    required this.medicineHistoryController3,
    required this.medicineAllergicController1,
    required this.medicineAllergicController2,
    required this.medicineAllergicController3,
    required this.medicalRecordController1,
    required this.medicalRecordController2,
    required this.medicalRecordController3,
    required this.riskFactorsController1,
    required this.riskFactorsController2,
    required this.riskFactorsController3,
  });

  @override
  State<AcceptButton> createState() => _AcceptButtonState();
}

class _AcceptButtonState extends State<AcceptButton> {
  String sysBloodPressure = '';
  String diaBloodPressure = '';
  String chronicDisease1 = '';
  String chronicDisease2 = '';
  String chronicDisease3 = '';
  String medicineHistory1 = '';
  String medicineHistory2 = '';
  String medicineHistory3 = '';
  String medicineAllergic1 = '';
  String medicineAllergic2 = '';
  String medicineAllergic3 = '';
  String medicalRecord1 = '';
  String medicalRecord2 = '';
  String medicalRecord3 = '';
  String riskFactor1 = '';
  String riskFactor2 = '';
  String riskFactor3 = '';
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        setState(() {
          sysBloodPressure = widget.sysbloodpressureController.text;
          diaBloodPressure = widget.diabloodpressureController.text;
          chronicDisease1 = widget.chronicDiseaseController1.text;
          chronicDisease2 = widget.chronicDiseaseController2.text;
          chronicDisease3 = widget.chronicDiseaseController3.text;
          medicineHistory1 = widget.medicineHistoryController1.text;
          medicineHistory2 = widget.medicineHistoryController2.text;
          medicineHistory3 = widget.medicineHistoryController3.text;
          medicineAllergic1 = widget.medicineAllergicController1.text;
          medicineAllergic2 = widget.medicineAllergicController2.text;
          medicineAllergic3 = widget.medicineAllergicController3.text;
          medicalRecord1 = widget.medicalRecordController1.text;
          medicalRecord2 = widget.medicalRecordController2.text;
          medicalRecord3 = widget.medicalRecordController3.text;
          riskFactor1 = widget.riskFactorsController1.text;
          riskFactor2 = widget.riskFactorsController2.text;
          riskFactor3 = widget.riskFactorsController3.text;
        });
        // print('Username: $username');
        // print('Password: $password');

        HealthInfo.setHealthInfo(
          sysBloodPressure: sysBloodPressure,
          diaBloodPressure: diaBloodPressure,
          chronicDisease1: chronicDisease1,
          chronicDisease2: chronicDisease2,
          chronicDisease3: chronicDisease3,
          medicineHistory1: medicineHistory1,
          medicineHistory2: medicineHistory2,
          medicineHistory3: medicineHistory3,
          medicineAllergic1: medicineAllergic1,
          medicineAllergic2: medicineAllergic2,
          medicineAllergic3: medicineAllergic3,
          medicalRecord1: medicalRecord1,
          medicalRecord2: medicalRecord2,
          medicalRecord3: medicalRecord3,
          riskFactor1: riskFactor1,
          riskFactor2: riskFactor2,
          riskFactor3: riskFactor3,
        );

        final healthInfoData = HealthInfo.getHealthInfo();

        db
            .collection("UserInfo")
            .doc(UserKey.userKey)
            .set({
              "HealthInfo": healthInfoData,
            }, SetOptions(merge: true)) // merge to update existing fields
            .onError((e, _) => print("Error writing document: $e"));

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserMain()),
        );
      },

      child: Container(
        width: 150,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: MyColor.bluePrimary,
          border: Border.all(color: MyColor.black, width: 1.0),
        ),
        child: Center(
          child: Text(
            diaBloodPressure.isNotEmpty ? diaBloodPressure : "ยืนยัน",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
