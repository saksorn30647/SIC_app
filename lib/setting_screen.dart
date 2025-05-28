import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sic_app/custom/custom_color.dart';
import 'package:sic_app/custom/health_info.dart';
import 'package:sic_app/custom/personal_info.dart';
import 'package:sic_app/health_info_setting.dart';
import 'package:sic_app/personal_info_setting.dart';
import 'package:sic_app/user_main.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreen();
}

class _SettingScreen extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [PersonalInfoBox(), HealthInfoSettingBox(), BackButton()],
        ),
      ),
    );
  }
}

class PersonalInfoHeading extends StatelessWidget {
  const PersonalInfoHeading({super.key});

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
              color: MyColor.pinkPrimary,
              border: Border(
                bottom: BorderSide(color: MyColor.black, width: 1),
              ), // Border.all
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                child: Text(
                  "ข้อมูลส่วนตัว",
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

class OneOutputRow extends StatelessWidget {
  final String output;

  const OneOutputRow({super.key, required this.output});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Text(
              output,
              style: TextStyle(color: MyColor.black, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}

class TwoOutputRow extends StatelessWidget {
  final String output1;
  final String output2;

  const TwoOutputRow({super.key, required this.output1, required this.output2});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  output1,
                  style: TextStyle(color: MyColor.black, fontSize: 18),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  output2,
                  style: TextStyle(color: MyColor.black, fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PersonalInfoEditButton extends StatelessWidget {
  const PersonalInfoEditButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PersonalInfoSetting()),
            );
          },
          child: Container(
            width: 75,
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              color: MyColor.pinkPrimary,
              border: Border(
                top: BorderSide(color: MyColor.black, width: 1),
                left: BorderSide(color: MyColor.black, width: 1),
              ), // Border.all
              // Border.all
            ),
            child: Center(
              child: Text(
                "แก้ไข",
                style: const TextStyle(fontSize: 20, color: MyColor.black),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HealthInfoSettingBox extends StatelessWidget {
  const HealthInfoSettingBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: MyColor.squareColor,
            border: Border.all(color: MyColor.black, width: 1.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              HealthInfoHeading(),
              HealthInfoContent(),
              HealthInfoEditButton(),
            ],
          ),
        ),
      ],
    );
  }
}

class HealthInfoHeading extends StatelessWidget {
  const HealthInfoHeading({super.key});

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
              color: MyColor.bluePrimary,
              border: Border(
                bottom: BorderSide(color: MyColor.black, width: 1),
              ), // Border.all
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                child: Text(
                  "ข้อมูลสุขภาพ",
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

class HealthInfoContent extends StatefulWidget {
  const HealthInfoContent({super.key});

  @override
  State<HealthInfoContent> createState() => _HealthInfoContentState();
}

class _HealthInfoContentState extends State<HealthInfoContent> {
  @override
  void initState() {
    super.initState();
    HealthInfo.cloudHealthInfoGetter(onUpdate: () => setState(() {}));
  } 

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              OneOutputRow(
                output:
                    'ความดันโลหิต : ${(HealthInfo.sysBloodPressure)}/${(HealthInfo.diaBloodPressure)}',
              ),
              ThreeOutputColumn(
                output1: 'โรคประจำตัว: 1.${(HealthInfo.chronicDisease1)} ',
                output2: '2.${(HealthInfo.chronicDisease2)}',
                output3: '3.${(HealthInfo.chronicDisease3)}',
              ),
              ThreeOutputColumn(
                output1: 'ประวัติการใช้ยา: 1.${(HealthInfo.medicineHistory1)} ',
                output2: '2.${(HealthInfo.medicineHistory2)}',
                output3: '3.${(HealthInfo.medicineHistory3)}',
              ),
              ThreeOutputColumn(
                output1: 'ประวัติการแพ้ยา: 1.${(HealthInfo.medicineAllergic1)} ',
                output2: '2.${(HealthInfo.medicineAllergic1)}',
                output3: '3.${(HealthInfo.medicineAllergic3)}',
              ),
              ThreeOutputColumn(
                output1: 'ประวัติการรักษา: 1.${(HealthInfo.medicalRecord1)} ',
                output2: '2.${(HealthInfo.medicalRecord2)}',
                output3: '3.${(HealthInfo.medicalRecord3)}',
              ),
              ThreeOutputColumn(
                output1: 'ปัจจัยเสี่ยง: 1.${(HealthInfo.riskFactor1)} ',
                output2: '2.${(HealthInfo.riskFactor2)}',
                output3: '3.${(HealthInfo.riskFactor3)}',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ThreeOutputColumn extends StatelessWidget {
  final String output1;
  final String output2;
  final String output3;

  const ThreeOutputColumn({
    required this.output1,
    required this.output2,
    required this.output3,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        OneOutputRow(output: output1),
        TwoOutputRow(output1: output2, output2: output3),
      ],
    );
  }
}

class HealthInfoEditButton extends StatelessWidget {
  const HealthInfoEditButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HealthInfoSetting()),
            );
          },
          child: Container(
            width: 75,
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              color: MyColor.bluePrimary,
              border: Border(
                top: BorderSide(color: MyColor.black, width: 1),
                left: BorderSide(color: MyColor.black, width: 1),
              ), // Border.all
              // Border.all
            ),
            child: Center(
              child: Text(
                "แก้ไข",
                style: const TextStyle(fontSize: 20, color: MyColor.black),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => UserMain()),
        );
        // Call your onPressed or onTap function here
      },
      child: Container(
        width: 120,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: MyColor.bluePrimary,
          border: Border.all(color: MyColor.black, width: 1.0), // Border.all),
        ),
        child: Center(child: Text("ย้อนกลับ", style: TextStyle(fontSize: 20))),
      ),
    );
  }
}

class PersonalInfoData extends StatefulWidget {
  const PersonalInfoData({super.key});

  @override
  State<PersonalInfoData> createState() => _PersonalInfoData();
  
}

class _PersonalInfoData extends State<PersonalInfoData> {
  @override
    void initState() {
      super.initState();
      PersonalInfo.cloudPersonalInfoGetter(onUpdate: () => setState(() {}));
    }

  @override
  Widget build(BuildContext context) {
    return 
    Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TwoOutputRow(
              output1: 'ชื่อ : ${(PersonalInfo.name)}',
              output2: 'ชื่อเล่น : ${(PersonalInfo.nickname)}',
            ),
            OneOutputRow(output: 'นามสกุล : ${(PersonalInfo.surname)}'),
            OneOutputRow(
              output:
                  'วันเกิด : ${(PersonalInfo.date)}/${(PersonalInfo.month)}/${(PersonalInfo.year)}',
            ),
            OneOutputRow(output: 'เพศ : ${(PersonalInfo.gender)}'),
            OneOutputRow(output: 'กรุ๊ปเลือด : ${(PersonalInfo.bloodGroup)}'),
            TwoOutputRow(
              output1: 'น้ำหนัก : ${(PersonalInfo.weight)} กก.',
              output2: 'ส่วนสูง : ${(PersonalInfo.height)} ซม.',
            ),
            OneOutputRow(output: 'บัตรประชาชน : ${(PersonalInfo.id)}'),
            OneOutputRow(
              output: 'เบอร์ติดต่อฉุกเฉิน : ${(PersonalInfo.emergencyContact)}',
            ),
          ],
        ),
      ),
    );
  }
}

class PersonalInfoBox extends StatefulWidget {
  const PersonalInfoBox({super.key});

  @override
  State<PersonalInfoBox> createState() => _PersonalInfoBox();
}

class _PersonalInfoBox extends State<PersonalInfoBox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: MyColor.squareColor,
              border: Border.all(color: MyColor.black, width: 1.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                PersonalInfoHeading(),
                PersonalInfoData(),
                PersonalInfoEditButton(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

