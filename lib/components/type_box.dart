import 'package:flutter/material.dart';
import 'package:sic_app/custom/custom_color.dart';

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
    return Row(
       mainAxisSize: MainAxisSize.max,
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
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
                onChanged: onChanged,
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

