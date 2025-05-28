import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sic_app/custom/custom_color.dart';
import 'package:sic_app/custom/login_choice.dart';
import 'package:sic_app/custom/my_user_info.dart';
import 'package:sic_app/custom/user_key.dart';
import 'package:sic_app/doctor_danger.dart';
import 'package:sic_app/doctor_main.dart';
import 'package:sic_app/login_screen.dart';
import 'package:sic_app/register_enter_form.dart';
import 'package:sic_app/user_main.dart';

class LoginEnterForm extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginEnterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              MyColor.bluePrimary,
              MyColor.blueSecondary,
              MyColor.white,
            ],
            stops: [0, 0.4, 0.6],
            // tileMode: TileMode.mirror,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 150, bottom: 30),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Form(
                        usernameController: _usernameController,
                        passwordController: _passwordController,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Center(
                  child: ButtonPanel(
                    usernameController: _usernameController,
                    passwordController: _passwordController,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Form extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  const Form({
    super.key,
    required this.usernameController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: MyColor.squareColor,
        border: Border.all(color: MyColor.black, width: 1.0), // Border.all
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              UsernameText(),
              SizedBox(height: 20),
              UsernameTypebox(textController: usernameController),
              SizedBox(height: 20),
              PasswordText(),
              SizedBox(height: 20),
              PasswordTypebox(textController: passwordController),
              SizedBox(height: 20),
              Remember(),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterEnterForm(),
                        ),
                      );
                    },
                    child: Text(
                      "ลืมรหัสผ่าน",
                      style: TextStyle(
                        fontSize: 12,
                        color: MyColor.bluePrimary,
                        decoration: TextDecoration.underline,
                        decorationColor: MyColor.bluePrimary,
                      ),
                    ),
                  ),
                  Text(
                    "หรือ",
                    style: TextStyle(
                      fontSize: 12,
                      color: MyColor.black.withAlpha(128),
                      decorationColor: MyColor.bluePrimary,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterEnterForm(),
                        ),
                      );
                    },
                    child: Text(
                      "สมัครบัญชีใหม่",
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
            ],
          ),
        ),
      ),
    );
  }
}

class UsernameText extends StatelessWidget {
  const UsernameText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [Text("โปรดกรอกชื่อผู้ใช้", style: TextStyle(fontSize: 20))],
    );
  }
}

class UsernameTypebox extends StatelessWidget {
  final TextEditingController textController;

  const UsernameTypebox({super.key, required this.textController});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: MyColor.squareColor,
        border: Border.all(color: MyColor.black, width: 1.0), // Border.all
      ),
      child: Center(
        child: TextField(
          controller: textController,
          decoration: InputDecoration(
            hintText: "enter username",
            border: InputBorder.none,
          ),
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class PasswordText extends StatelessWidget {
  const PasswordText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [Text("โปรดกรอกรหัสผ่าน", style: TextStyle(fontSize: 20))],
    );
  }
}

class PasswordTypebox extends StatelessWidget {
  final TextEditingController textController;

  const PasswordTypebox({super.key, required this.textController});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: MyColor.squareColor,
        border: Border.all(color: MyColor.black, width: 1.0), // Border.all
      ),
      child: Center(
        child: TextField(
          controller: textController,
          decoration: InputDecoration(
            hintText: "enter password",
            border: InputBorder.none,
          ),
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class Remember extends StatefulWidget {
  const Remember({super.key});

  @override
  State<StatefulWidget> createState() => _RememberState();
}

class _RememberState extends State<Remember> {
  bool isChecked = false;

  void toggleCheckbox() {
    setState(() {
      isChecked = !isChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
          () => {
            setState(() {
              isChecked = !isChecked;
            }),
          },
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Checkbox(isChecked: isChecked),
          SizedBox(width: 10),
          Text("จดจำผู้ใช้งาน", style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}

class Checkbox extends StatelessWidget {
  final bool isChecked;

  const Checkbox({super.key, required this.isChecked});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      isChecked ? 'assets/checkbox_check.svg' : 'assets/checkbox_uncheck.svg',
      width: 15,
      height: 15,
    );
  }
}

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegisterEnterForm()),
        );
        // Call your onPressed or onTap function here
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: MyColor.squareColor,
                border: Border.all(
                  color: MyColor.black,
                  width: 1.0,
                ), // Border.all),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "สมัครบัญชีผู้ใช้ใหม่",
                      style: TextStyle(fontSize: 20, color: MyColor.black),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonPanel extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  const ButtonPanel({
    super.key,
    required this.usernameController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BackButton(),
            Expanded(child: SizedBox()),
            AcceptButton(
              usernameController: usernameController,
              passwordController: passwordController,
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
        // Call your onPressed or onTap function here
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginSceen()),
        );
      },
      child: Container(
        width: 150,
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

class AcceptButton extends StatefulWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  const AcceptButton({
    super.key,
    required this.usernameController,
    required this.passwordController,
  });

  @override
  State<AcceptButton> createState() => _AcceptButtonState();
}

class _AcceptButtonState extends State<AcceptButton> {
  String username = '';
  String password = '';
  Future<bool> anyPatientInEmergency() async {
    final db = FirebaseFirestore.instance;

    final snap =
        await db
            .collection('UserInfo')
            .where('EmergencyState', isEqualTo: true)
            .limit(1) // we only need to know if ONE exists
            .get();

    return snap.docs.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () async {
        setState(() {
          username = widget.usernameController.text;
          password = widget.passwordController.text;
        });
        // print('Username: $username');
        // print('Password: $password');
        MyUserInfo.username = username;
        MyUserInfo.password = password;

        UserKey.setUserKey(userkey: username);

        print('Username: ${MyUserInfo.username}');
        print('Password: ${MyUserInfo.password}');
        print('UserKey: ${UserKey.userKey}');

        try {
          await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                email: MyUserInfo.username,
                password: MyUserInfo.password,
              )
              .then((value) async {
                if (IsLoginForEldery.isElderly == true) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserMain()),
                  );
                } else {
                  final hasEmergency = await anyPatientInEmergency();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) =>
                              hasEmergency
                                  ? const DoctorDanger()
                                  : const DoctorMain(),
                    ),
                  );
                }
              });
        } on FirebaseAuthException catch (e) {
          print('${e}');
        }
        print('Login successful');
      },

      child: Container(
        width: 150,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: MyColor.pinkPrimary,
          border: Border.all(color: MyColor.black, width: 1.0),
        ),
        child: Center(child: Text("ยืนยัน", style: TextStyle(fontSize: 20))),
      ),
    );
  }
}
