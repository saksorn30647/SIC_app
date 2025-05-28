import 'package:flutter/material.dart';
import 'package:sic_app/custom/custom_color.dart';

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
    return Expanded(
      child: Container(
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
      ),
    );
  }
}