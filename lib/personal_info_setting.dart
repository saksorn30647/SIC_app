// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sic_app/custom/custom_color.dart';
import 'package:sic_app/custom/personal_info.dart';
import 'package:sic_app/custom/user_key.dart';
import 'package:sic_app/health_info_setting.dart';

class PersonalInfoSetting extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _yearsController = TextEditingController();
  final TextEditingController _datesController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _emergencycallController =
      TextEditingController();
  PersonalInfoSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              MyColor.pinkSecondary,
              MyColor.white,
              MyColor.white,
              MyColor.pinkPrimary,
            ],
            stops: [0.01, 0.31, 0.55, 0.91],
            // tileMode: TileMode.mirror,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SettingForm(
                  nameController: _nameController,
                  surnameController: _surnameController,
                  nicknameController: _nicknameController,
                  yearsController: _yearsController,
                  datesController: _datesController,
                  weightController: _weightController,
                  heightController: _heightController,
                  idController: _idController,
                  emergencycallController: _emergencycallController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SettingForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController surnameController;
  final TextEditingController nicknameController;
  final TextEditingController yearsController;
  final TextEditingController datesController;
  final TextEditingController weightController;
  final TextEditingController heightController;
  final TextEditingController idController;
  final TextEditingController emergencycallController;

  const SettingForm({
    super.key,
    required this.nameController,
    required this.surnameController,
    required this.nicknameController,
    required this.yearsController,
    required this.datesController,
    required this.weightController,
    required this.heightController,
    required this.idController,
    required this.emergencycallController,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: 365,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: MyColor.white,
          border: Border.all(color: MyColor.black, width: 1.0), // Border.all
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  Heading(),
                  Setting(
                    nameController: nameController,
                    surnameController: surnameController,
                    nicknameController: nicknameController,
                    datesController: datesController,
                    yearsController: yearsController,
                    weightController: weightController,
                    heightController: heightController,
                    idController: idController,
                    emergencycallController: emergencycallController,
                  ),
                ],
              ),
            ),
            ButtonPanel(
              nameController: nameController,
              surnameController: surnameController,
              nicknameController: nicknameController,
              yearsController: yearsController,
              datesController: datesController,
              weightController: weightController,
              heightController: heightController,
              idController: idController,
              emergencycallController: emergencycallController,
            ),
          ],
        ),
      ),
    );
  }
}

class Setting extends StatelessWidget {
  const Setting({
    super.key,
    required this.nameController,
    required this.surnameController,
    required this.nicknameController,
    required this.datesController,
    required this.yearsController,
    required this.weightController,
    required this.heightController,
    required this.idController,
    required this.emergencycallController,
  });

  final TextEditingController nameController;
  final TextEditingController surnameController;
  final TextEditingController nicknameController;
  final TextEditingController datesController;
  final TextEditingController yearsController;
  final TextEditingController weightController;
  final TextEditingController heightController;
  final TextEditingController idController;
  final TextEditingController emergencycallController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InputRow(
              text: Text(
                "ชื่อ :",
                style: TextStyle(fontSize: 20, color: MyColor.black),
              ),
              hintText: Text("กรุณากรอกชื่อ"),
              textController: nameController,
            ),

            InputRow(
              text: Text(
                "นามสกุล :",
                style: TextStyle(fontSize: 20, color: MyColor.black),
              ),
              hintText: Text("กรุณากรอกนามสกุล"),
              textController: surnameController,
            ),

            InputRow(
              text: Text(
                "ชื่อเล่น :",
                style: TextStyle(fontSize: 20, color: MyColor.black),
              ),
              hintText: Text("กรุณากรอกชื่อเล่น"),
              textController: nicknameController,
            ),

            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "วัน",
                        style: const TextStyle(
                          fontSize: 20,
                          color: MyColor.black,
                        ),
                      ),
                      BirthDateDropdown(),
                    ],
                  ),
                ),

                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "เดือน",
                        style: const TextStyle(
                          fontSize: 20,
                          color: MyColor.black,
                        ),
                      ),
                      MonthDropdown(),
                    ],
                  ),
                ),

                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ปีเกิด",
                        style: const TextStyle(
                          fontSize: 20,
                          color: MyColor.black,
                        ),
                      ),
                      BirthYearDropdown(),
                    ],
                  ),
                ),
              ],
            ),

            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "เพศ :",
                  style: const TextStyle(fontSize: 20, color: MyColor.black),
                ),
                GenderDropdown(),
              ],
            ),

            NumberInputRow(
              text: Text(
                "น้ำหนัก :",
                style: TextStyle(fontSize: 20, color: MyColor.black),
              ),
              hintText: Text("น้ำหนัก (กิโลกรัม)"),
              textController: weightController,
            ),

            NumberInputRow(
              text: Text(
                "ส่วนสูง :",
                style: TextStyle(fontSize: 20, color: MyColor.black),
              ),
              hintText: Text("ส่วนสูง (เซนติเมตร)"),
              textController: heightController,
            ),

            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "กร๊ปเลือด :",
                  style: const TextStyle(fontSize: 20, color: MyColor.black),
                ),
                BloodGroupDropdown(),
              ],
            ),

            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "รหัสบัตรประชาชน :",
                  style: const TextStyle(fontSize: 20, color: MyColor.black),
                ),
              ],
            ),

            LongNumberTypeBox(
              hintText: "รหัสบัตรประชาชน :",
              textController: idController,
            ),

            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "เบอร์ติดต่อฉุกเฉิน :",
                  style: const TextStyle(fontSize: 20, color: MyColor.black),
                ),
              ],
            ),

            LongNumberTypeBox(
              hintText: "เบอร์ติดต่อฉุกเฉิน :",
              textController: emergencycallController,
            ),
          ],
        ),
      ),
    );
  }
}

class Heading extends StatelessWidget {
  const Heading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 365,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: MyColor.pinkSecondary,
        border: Border(
          bottom: BorderSide(color: MyColor.black, width: 1),
        ), // Border.all
      ),
      child: Center(
        child: Text(
          "ตั้งค่าข้อมูลส่วนตัว",
          style: const TextStyle(fontSize: 20, color: MyColor.black),
        ),
      ),
    );
  }
}

class InputRow extends StatelessWidget {
  final Text text;
  final Text hintText;
  final TextEditingController textController;

  const InputRow({
    super.key,
    required this.text,
    required this.hintText,
    required this.textController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 345,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          text,
          Typebox(textController: textController, hintText: hintText.data!),
        ],
      ),
    );
  }
}

class NumberInputRow extends StatelessWidget {
  final Text text;
  final Text hintText;
  final TextEditingController textController;

  const NumberInputRow({
    super.key,
    required this.text,
    required this.hintText,
    required this.textController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 345,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          text,
          NumberTypeBox(
            textController: textController,
            hintText: hintText.data!,
          ),
        ],
      ),
    );
  }
}

class NumberTypeBox extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  const NumberTypeBox({
    super.key,
    required this.textController,
    this.hintText = "",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: MyColor.squareColor,
        border: Border.all(color: MyColor.black, width: 1.0), // Border.all
      ),
      child: Center(
        child: TextField(
          controller: textController,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: MyColor.black.withAlpha(154),
              fontSize: 20,
            ),
            border: InputBorder.none,
          ),
          onChanged: (value) {
            // Ensure only numbers are entered
            if (value.isNotEmpty && !RegExp(r'^[0-9]+$').hasMatch(value)) {
              textController.text = value.substring(0, value.length - 1);
              textController.selection = TextSelection.fromPosition(
                TextPosition(offset: textController.text.length),
              );
            }
          },
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
        ),
      ),
    );
  }
}

class LongNumberTypeBox extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  const LongNumberTypeBox({
    super.key,
    required this.textController,
    this.hintText = "",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 345,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: MyColor.squareColor,
        border: Border.all(color: MyColor.black, width: 1.0), // Border.all
      ),
      child: Center(
        child: TextField(
          controller: textController,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: MyColor.black.withAlpha(154),
              fontSize: 20,
            ),
            border: InputBorder.none,
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],

          // onChanged: (value) {
          //   // Ensure only numbers are entered
          //   if (value.isNotEmpty && !RegExp(r'^[0-9]+$').hasMatch(value)) {
          //     textController.text = value.substring(0, value.length - 1);
          //     textController.selection = TextSelection.fromPosition(
          //       TextPosition(offset: textController.text.length),
          //     );
          //   }
          // },
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
          // keyboardType: TextInputType.number,
        ),
      ),
    );
  }
}

class Typebox extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final Function(String)? onChanged;
  const Typebox({
    super.key,
    required this.textController,
    this.hintText = "",
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: MyColor.squareColor,
        border: Border.all(color: MyColor.black, width: 1.0), // Border.all
      ),
      child: Center(
        child: TextField(
          controller: textController,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: MyColor.black.withAlpha(154),
              fontSize: 20,
            ),
            border: InputBorder.none,
          ),
          onChanged: onChanged,
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class ShortTypebox extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final Function(String)? onChanged;

  const ShortTypebox({
    super.key,
    required this.textController,
    this.hintText = "",
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: MyColor.squareColor,
        border: Border.all(color: MyColor.black, width: 1.0), // Border.all
      ),
      child: Center(
        child: TextField(
          controller: textController,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: MyColor.black.withAlpha(154),
              fontSize: 20,
            ),
            border: InputBorder.none,
          ),
          onChanged: onChanged,
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class MonthDropdown extends StatefulWidget {
  const MonthDropdown({super.key});

  @override
  _MonthDropdownState createState() => _MonthDropdownState();
}

class _MonthDropdownState extends State<MonthDropdown> {
  String month = '';
  String dropdownvalue = items[0];

  static const List<String> items = [
    'ม.ค.',
    'ก.พ.',
    'มี.ค.',
    'ม.ย.',
    'พ.ค.',
    'มิ.ย.',
    'ก.ค.',
    'ส.ค.',
    'ก.ย.',
    'ต.ค.',
    'พ.ย.',
    'ธ.ค.',
  ];

  @override
  Widget build(BuildContext context) {
    return (Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: MyColor.squareColor,
        border: Border.all(color: MyColor.black, width: 1.0), // Border.all
      ),
      child: Center(
        child: DropdownButton<String>(
          value: dropdownvalue,
          icon: const Icon(Icons.arrow_drop_down),
          elevation: 16,
          style: const TextStyle(color: MyColor.black, fontSize: 20),

          onChanged: (String? newValue) {
            setState(() {
              dropdownvalue = newValue!;
              month = dropdownvalue;
              PersonalInfo.month = month;
            });
          },

          items:
              items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
        ),
      ),
    ));
  }
}

class GenderDropdown extends StatefulWidget {
  const GenderDropdown({super.key});

  @override
  _GenderDropdownState createState() => _GenderDropdownState();
}

class _GenderDropdownState extends State<GenderDropdown> {
  String gender = '';
  String dropdownvalue = items[0];
  static const List<String> items = ['ชาย', 'หญิง'];

  @override
  Widget build(BuildContext context) {
    return (Container(
      width: 250,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: MyColor.squareColor,
        border: Border.all(color: MyColor.black, width: 1.0), // Border.all
      ),
      child: Center(
        child: DropdownButton<String>(
          value: dropdownvalue,
          icon: const Icon(Icons.arrow_drop_down),
          elevation: 16,
          style: const TextStyle(color: MyColor.black, fontSize: 20),

          onChanged: (String? newValue) {
            setState(() {
              dropdownvalue = newValue!;
              gender = dropdownvalue;
              PersonalInfo.gender = gender;
            });
          },

          items:
              items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
        ),
      ),
    ));
  }
}

class BloodGroupDropdown extends StatefulWidget {
  const BloodGroupDropdown({super.key});

  @override
  _BloodGroupDropdownState createState() => _BloodGroupDropdownState();
}

class _BloodGroupDropdownState extends State<BloodGroupDropdown> {
  String bloodgroup = '';
  String dropdownvalue = items[0];
  static const List<String> items = ['A', 'B', 'AB', 'O', '-'];

  @override
  Widget build(BuildContext context) {
    return (Container(
      width: 250,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: MyColor.squareColor,
        border: Border.all(color: MyColor.black, width: 1.0), // Border.all
      ),
      child: Center(
        child: DropdownButton<String>(
          value: dropdownvalue,
          icon: const Icon(Icons.arrow_drop_down),
          //elevation: 16,
          style: const TextStyle(color: MyColor.black, fontSize: 20),

          onChanged: (String? newValue) {
            setState(() {
              dropdownvalue = newValue!;
              bloodgroup = dropdownvalue;
              PersonalInfo.bloodGroup = bloodgroup;
            });
          },

          items:
              items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
        ),
      ),
    ));
  }
}

class BirthDateDropdown extends StatefulWidget {
  const BirthDateDropdown({super.key});

  @override
  _BirthDateDropdownState createState() => _BirthDateDropdownState();
}

class _BirthDateDropdownState extends State<BirthDateDropdown> {
  String date = '';
  String dropdownvalue = items[0];
  static const List<String> items = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31',
  ];

  @override
  Widget build(BuildContext context) {
    return (Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: MyColor.squareColor,
        border: Border.all(color: MyColor.black, width: 1.0), // Border.all
      ),
      child: Center(
        child: DropdownButton<String>(
          value: dropdownvalue,
          icon: const Icon(Icons.arrow_drop_down),
          elevation: 16,
          style: const TextStyle(color: MyColor.black, fontSize: 20),

          onChanged: (String? newValue) {
            setState(() {
              dropdownvalue = newValue!;
              date = dropdownvalue;
              PersonalInfo.date = date;
            });
          },
          items:
              items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
        ),
      ),
    ));
  }
}

class BirthYearDropdown extends StatefulWidget {
  const BirthYearDropdown({super.key});

  @override
  _BirthYearDropdownState createState() => _BirthYearDropdownState();
}

class _BirthYearDropdownState extends State<BirthYearDropdown> {
  String year = '';
  String dropdownvalue = items[0];
  static const List<String> items = [
    "2568",
    "2567",
    "2566",
    "2565",
    "2564",
    "2563",
    "2562",
    "2561",
    "2560",
    "2559",
    "2558",
    "2557",
    "2556",
    "2555",
    "2554",
    "2553",
    "2552",
    "2551",
    "2550",
    "2549",
    "2548",
    "2547",
    "2546",
    "2545",
    "2544",
    "2543",
    "2542",
    "2541",
    "2540",
    "2539",
    "2538",
    "2537",
    "2536",
    "2535",
    "2534",
    "2533",
    "2532",
    "2531",
    "2530",
    "2529",
    "2528",
    "2527",
    "2526",
    "2525",
    "2524",
    "2523",
    "2522",
    "2521",
    "2520",
    "2519",
    "2518",
    "2517",
    "2516",
    "2515",
    "2514",
    "2513",
    "2512",
    "2511",
    "2510",
    "2509",
    "2508",
    "2507",
    "2506",
    "2505",
    "2504",
    "2503",
    "2502",
    "2501",
    "2500",
    "2499",
    "2498",
    "2497",
    "2496",
    "2495",
    "2494",
    "2493",
    "2492",
    "2491",
    "2490",
    "2489",
    "2488",
    "2487",
    "2486",
    "2485",
    "2484",
    "2483",
    "2482",
    "2481",
    "2480",
    "2479",
    "2478",
    "2477",
    "2476",
    "2475",
    "2474",
    "2473",
    "2472",
    "2471",
    "2470",
    "2469",
  ];

  @override
  Widget build(BuildContext context) {
    return (Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: MyColor.squareColor,
        border: Border.all(color: MyColor.black, width: 1.0), // Border.all
      ),
      child: Center(
        child: DropdownButton<String>(
          value: dropdownvalue,
          icon: const Icon(Icons.arrow_drop_down),
          elevation: 16,
          style: const TextStyle(color: MyColor.black, fontSize: 20),

          onChanged: (String? newValue) {
            setState(() {
              dropdownvalue = newValue!;
              year = dropdownvalue;
              PersonalInfo.year = year;
            });
          },
          items:
              items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
        ),
      ),
    ));
  }
}

class ButtonPanel extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController surnameController;
  final TextEditingController nicknameController;
  final TextEditingController yearsController;
  final TextEditingController datesController;
  final TextEditingController weightController;
  final TextEditingController heightController;
  final TextEditingController idController;
  final TextEditingController emergencycallController;

  const ButtonPanel({
    super.key,
    required this.nameController,
    required this.surnameController,
    required this.nicknameController,
    required this.yearsController,
    required this.datesController,
    required this.weightController,
    required this.heightController,
    required this.idController,
    required this.emergencycallController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: SizedBox(
        width: 360,
        height: 60,
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BackButton(),
              AcceptButton(
                nameController: nameController,
                surnameController: surnameController,
                nicknameController: nicknameController,

                weightController: weightController,
                heightController: heightController,
                idController: idController,
                emergencycallController: emergencycallController,
              ),
            ],
          ),
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
  final TextEditingController nameController;
  final TextEditingController surnameController;
  final TextEditingController nicknameController;

  final TextEditingController weightController;
  final TextEditingController heightController;
  final TextEditingController idController;
  final TextEditingController emergencycallController;

  const AcceptButton({
    super.key,
    required this.nameController,
    required this.surnameController,
    required this.nicknameController,

    required this.weightController,
    required this.heightController,
    required this.idController,
    required this.emergencycallController,
  });

  @override
  State<AcceptButton> createState() => _AcceptButtonState();
}

class _AcceptButtonState extends State<AcceptButton> {
  String name = '';
  String surname = '';
  String nickname = '';
  String weight = '';
  String height = '';
  String id = '';
  String emergencycall = '';
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: MyColor.pinkPrimary,
        border: Border.all(color: MyColor.black, width: 1.0),
      ),
      child: MaterialButton(
        onPressed: () {
          setState(() {
            name = widget.nameController.text;
            surname = widget.surnameController.text;
            nickname = widget.nicknameController.text;
            weight = widget.weightController.text;
            height = widget.heightController.text;
            id = widget.idController.text;
            emergencycall = widget.emergencycallController.text;
          });
          // print('Username: $username');
          // print('Password: $password');

          PersonalInfo.setPersonalInfo(
            name: name,
            surname: surname,
            nickname: nickname,
            weight: weight,
            height: height,
            id: id,
            emergencyContact: emergencycall,
          );
          print('name: ${PersonalInfo.name}');
          print('surname: ${PersonalInfo.surname}');
          print('nickname: ${PersonalInfo.nickname}');
          print('year: ${PersonalInfo.year}');
          print('month : ${PersonalInfo.month}');
          print('date: ${PersonalInfo.date}');
          print('weight: ${PersonalInfo.weight}');
          print('height: ${PersonalInfo.height}');
          print('id: ${PersonalInfo.id}');
          print('emergencycall: ${PersonalInfo.emergencyContact}');
          print('gender : ${PersonalInfo.gender}');
          print('bloodgroup : ${PersonalInfo.bloodGroup}');

          print("${FirebaseAuth.instance.currentUser?.uid}");

          final personalInfoData = PersonalInfo.getPersonalInfo();
          db
              .collection("UserInfo")
              .doc(UserKey.userKey)
              .set({
                "PersonalInfo": personalInfoData,
              }, SetOptions(merge: true)) // <-- merge option goes here
              .onError((e, _) => print("Error writing document: $e"));

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HealthInfoSetting()),
          );
        },
        child: Center(
          child: Text(
            name.isNotEmpty ? name : "ยืนยัน",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
