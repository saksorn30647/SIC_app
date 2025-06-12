// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import 'package:sic_app/custom/custom_color.dart';
import 'package:sic_app/custom/emergency_state.dart';
import 'package:sic_app/image_picker_screen.dart';
import 'package:sic_app/my_image_view.dart';
import 'package:sic_app/user_main.dart';

class FaceScanTutorialScreen extends StatelessWidget {
  FaceScanTutorialScreen({super.key});

  late VoidCallback onNext;
  late VoidCallback onBack;

  void next() {
    if (onNext != null) {
      onNext();
    }
  }

  void back() {
    if (onBack != null) {
      onBack();
    }
  }

  @override
  Widget build(BuildContext context) {
    MainContent mainContent = MainContent(
      setNextStepCallback: (callback) {
        onNext = callback;
      },
      setPreviousStepCallback: (callback) {
        onBack = callback;
      },
    );

    return Material(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [MyColor.white, MyColor.blueSecondary, MyColor.bluePrimary],
            stops: [0.0, 0.7, 1.0],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 20,
            children: [
              Expanded(child: mainContent),
              Buttons(onNext: next, onBack: back),
            ],
          ),
        ),
      ),
    );
  }
}

class MainContent extends StatefulWidget {
  int expandingStep = 0;
  int numSteps = 3;

  final void Function(VoidCallback) setNextStepCallback;
  final void Function(VoidCallback) setPreviousStepCallback;

  MainContent({
    super.key,
    required this.setNextStepCallback,
    required this.setPreviousStepCallback,
  });

  @override
  State<MainContent> createState() => _MainContentState();
}

class Step {
  String text;
  String image;

  Step({required this.text, required this.image});
}

class _MainContentState extends State<MainContent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Step> steps = [
      Step(text: "1. กด สแกนหน้าประจำวัน", image: "assets/face_scan_guide_1.png"),
      Step(text: "2. อ่านคู่มือถ่ายรูป", image: "assets/face_scan_guide_2.png"),
      Step(text: "3. กดปุ่มถ่ายรูป", image: "assets/face_scan_guide_3.png"),
      Step(text: "4. ถ่ายรูปหน้าตรง", image: "assets/face_scan_guide_4.png"),
      Step(text: "5. เลือกรูปภาพ", image: "assets/face_scan_guide_5.png"),
      Step(text: "6. ดูผลการสแกนหน้า", image: "assets/face_scan_guide_6.png"),
    ];
    widget.numSteps = steps.length;

    widget.setNextStepCallback(nextStep);
    widget.setPreviousStepCallback(previousStep);

    List<StepWidget> listStepWidget = [];
    for (var i = 0; i < widget.numSteps; i++) {
      listStepWidget.add(
        StepWidget(
          text: steps[i].text,
          image: steps[i].image,
          isExpanding:
              i == (widget.expandingStep % widget.numSteps) ? true : false,
          onClick:
              () => setState(() {
                widget.expandingStep = i;
              }),
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 20,
      children: [
        FillRowText(text: "วิธีใช้งานระบบสแกนหน้าประจำวัน"),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              spacing: 20,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: listStepWidget,
            ),
          ),
        ),
      ],
    );
  }

  void nextStep() {
    if (widget.expandingStep + 1 == widget.numSteps) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ImagePickerScreen()),
      );
      return;
    }
    setState(() {
      widget.expandingStep++;
    });
  }

  void previousStep() {
    if (widget.expandingStep == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserMain()),
      );
      return;
    }
    setState(() {
      widget.expandingStep--;
    });
  }
}

class FillRowText extends StatelessWidget {
  final String text;

  const FillRowText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyColor.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: MyColor.black, width: 1.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text, style: TextStyle(fontSize: 20, color: MyColor.black)),
          ],
        ),
      ),
    );
  }
}

class StepWidget extends StatelessWidget {
  final String text;
  final String image;
  final bool isExpanding;

  final Function onClick;

  const StepWidget({
    super.key,
    required this.text,
    required this.image,
    required this.isExpanding,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    Widget children = Text(
      text,
      style: TextStyle(fontSize: 20, color: MyColor.black),
    );

    if (isExpanding) {
      children = Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.hardEdge,  
        child: Image.asset(
          image,
        ),
      );
    } else {
      children = Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [children],
        ),
      );
    }

    Widget child = Container(
      decoration: BoxDecoration(
        color: MyColor.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: MyColor.black, width: 1.0),
      ),
      child: children,
    );

    if (isExpanding) {
      return child;
    }
    return InkWell(
      onTap: () {
        onClick();
      },
      child: child,
    );
  }
}

class Buttons extends StatelessWidget {
  final Function onNext;
  final Function onBack;

  const Buttons({super.key, required this.onNext, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Button(text: "ย้อนกลับ", onClick: onBack, color: MyColor.bluePrimary),
        Button(text: "ถัดไป", onClick: onNext, color: MyColor.pinkPrimary),
      ],
    );
  }
}

class Button extends StatelessWidget {
  final String text;
  final Color color;
  final Function onClick;

  const Button({
    super.key,
    required this.text,
    required this.onClick,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClick();
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: MyColor.black, width: 1.0),
        ),
        width: 150.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Center(
            child: Text(
              text,
              style: TextStyle(color: MyColor.black, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
