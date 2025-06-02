import 'package:flutter/material.dart';
import 'package:sic_app/custom/custom_color.dart';
import 'package:sic_app/custom/login_choice.dart';
import 'package:sic_app/login_enter_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              MyColor.white,
              MyColor.bluePrimary,
            ],
            // tileMode: TileMode.mirror,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [LogoBase(), LoginChoice()],
          ),
        ),
      ),
    );
  }
}

class LogoBase extends StatelessWidget {
  const LogoBase({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 320,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: MyColor.squareColor,
        border: Border.all(color: MyColor.black, width: 1.0), // Border.all),
      ),
    );
  }
}

class LoginChoice extends StatelessWidget {
  const LoginChoice({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: MyColor.squareColor,
        border: Border.all(color: MyColor.black, width: 1.0), // Border.all
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("โปรดเลือกรูปแบบการใช้งาน", style: TextStyle(fontSize: 20)),
                SizedBox(height: 20),
                LoginForElderly(),
                SizedBox(height: 20),
                LoginForMed(),
              ],
            ),
            TextButton(
              onPressed: () {
                print('Privacy policy tapped');
                // Call your onPressed or onTap function here
              },
              child: Text(
                "Term of service",
                style: TextStyle(
                  fontSize: 12,
                  color: MyColor.bluePrimary,
                  decoration: TextDecoration.underline,
                  decorationColor: MyColor.bluePrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginForElderly extends StatelessWidget {
  const LoginForElderly({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        IsLoginForEldery.isElderly = true;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginEnterForm()),
        );
        print('Login for elderly tapped');
        // Call your onPressed or onTap function here
      },
      child: Container(
        width: 320,
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: MyColor.squareColor,
          border: Border.all(color: MyColor.black, width: 1.0), // Border.all),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 10),
            CircleButton1(),
            SizedBox(width: 35),
            Text("ผู้ใช้งานจริง", style: TextStyle(fontSize: 30)),
          ],
        ),
      ),
    );
  }
}

class CircleButton1 extends StatelessWidget {
  const CircleButton1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: MyColor.pinkSecondary.withAlpha(154),
        border: Border.all(color: MyColor.black.withAlpha(154), width: 1.0),
      ),
    );
  }
}

class LoginForMed extends StatelessWidget {
  
  LoginForMed({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        IsLoginForEldery.isElderly = false;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginEnterForm()),
        );
        // Call your onPressed or onTap function here
      },
      child: Container(
        width: 320,
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: MyColor.squareColor,
          border: Border.all(color: MyColor.black, width: 1.0), // Border.all),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 10),
            CircleButton1(),
            SizedBox(width: 35),
            Text("แพทย์", style: TextStyle(fontSize: 30)),
          ],
        ),
      ),
    );
  }
}

class CircleButton2 extends StatelessWidget {
  const CircleButton2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: MyColor.pinkSecondary.withAlpha(154),
        border: Border.all(color: MyColor.black.withAlpha(154), width: 1.0),
      ),
    );
  }
}
