import 'package:flutter/material.dart';
import 'package:sic_app/components/type_box.dart';
import 'package:sic_app/custom/custom_color.dart';

class HealthInfoFormat extends StatelessWidget {
  final TextEditingController textController1;
  final TextEditingController textController2;
  final TextEditingController textController3;
  final String hintText1;
  final String hintText2;
  final String hintText3;
  final String title;

  const HealthInfoFormat({
    super.key,
    required this.textController1,
    required this.textController2,
    required this.textController3,
    this.hintText1 = "",
    this.hintText2 = "",
    this.hintText3 = "",
    this.title = "",
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 20, color: MyColor.black),
              ),
            ],
          ),
          SizedBox(height: 10),
          Typebox(
            
            textController: textController1,
            hintText: hintText1, 
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Typebox(
                  
                  textController: textController2,
                  hintText: hintText2,
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Typebox(
                  
                  textController: textController3,
                  hintText: hintText3,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}