import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sic_app/custom/custom_color.dart';
import 'package:sic_app/custom/my_user_info.dart';
import 'package:sic_app/custom/user_key.dart';
import 'package:sic_app/login_enter_form.dart';
import 'package:sic_app/personal_info_setting.dart';

class RegisterEnterForm extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _retypePasswordController =
      TextEditingController();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  RegisterEnterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: firebase,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: Text('error')),
            body: Center(child: Text('${snapshot.error}')),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
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
                padding: const EdgeInsets.only(top: 30, bottom: 30),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: 1),
                      Form(
                        usernameController: _usernameController,
                        passwordController: _passwordController,
                        phoneNumberController: _retypePasswordController,
                      ),
                      ButtonPanel(
                        usernameController: _usernameController,
                        passwordController: _passwordController,
                        retypePasswordController: _retypePasswordController,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        return Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
    //
  }
}

class Form extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController phoneNumberController;

  const Form({
    super.key,
    required this.usernameController,
    required this.passwordController,
    required this.phoneNumberController,
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
              PhonenumberText(),
              SizedBox(height: 20),
              PhoneNumberTypebox(textController: phoneNumberController),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginEnterForm()),
                  );
                },
                child: Text(
                  "ฉันมีบัญชีผู้ใช้แล้ว",
                  style: TextStyle(
                    fontSize: 12,
                    color: MyColor.black.withAlpha(205),
                    decoration: TextDecoration.underline,
                    decorationColor: MyColor.black,
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

class UsernameText extends StatelessWidget {
  const UsernameText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [Text("โปรดกรอกที่อยู่อีเมล", style: TextStyle(fontSize: 20))],
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
            hintText: "enter email address",
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

class PhonenumberText extends StatelessWidget {
  const PhonenumberText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [Text("โปรดกรอกเบอร์โทรศัพท์", style: TextStyle(fontSize: 20))],
    );
  }
}

class PhoneNumberTypebox extends StatelessWidget {
  final TextEditingController textController;

  const PhoneNumberTypebox({super.key, required this.textController});

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
            hintText: "enter phonenumber",
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

  const Checkbox({super.key, this.isChecked = false});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      isChecked ? 'assets/checkbox_check.svg' : 'assets/checkbox_uncheck.svg',
      width: 15,
      height: 15,
    );
  }
}

class ButtonPanel extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController retypePasswordController;

  const ButtonPanel({
    super.key,
    required this.usernameController,
    required this.passwordController,
    required this.retypePasswordController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      height: 60,
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BackButton(),
            AcceptButton(
              usernameController: usernameController,
              passwordController: passwordController,
              phoneNumberController: retypePasswordController,
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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginEnterForm()),
        );
        // Call your onPressed or onTap function here
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
  final TextEditingController phoneNumberController;

  const AcceptButton({
    super.key,
    required this.usernameController,
    required this.passwordController,
    required this.phoneNumberController,
  });

  @override
  State<AcceptButton> createState() => _AcceptButtonState();
}

class _AcceptButtonState extends State<AcceptButton> {
  String username = '';
  String password = '';
  String phoneNumber = '';
  final db = FirebaseFirestore.instance;

  final Text text = Text("ยืนยัน", style: TextStyle(fontSize: 20));
  final CircularProgressIndicator progressIndicator = CircularProgressIndicator(
    color: MyColor.white,
  );

  Widget buttonChild = Text("ยืนยัน", style: TextStyle(fontSize: 20));

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        setState(() {
          username = widget.usernameController.text;
          password = widget.passwordController.text;
          phoneNumber = widget.phoneNumberController.text;
          buttonChild = progressIndicator;
        });

        UserKey.userKey = username;
        MyUserInfo.setUserInfo(
          username: username,
          password: password,
          phoneNumber: phoneNumber,
        );


        print('Username: $username');
        print('Password: $password');
        print('PhoneNumber: $phoneNumber');

        FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: username, password: password)
            .then((value) {
              Fluttertoast.showToast(
                msg: "สร้างบัญชีผู้ใช้สำเร็จ",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: MyColor.bluePrimary,
                textColor: MyColor.white,
                fontSize: 16.0,
              );
              // setState(() {
              //   buttonChild = text;
              // });
              db
                  .collection("UserInfo")
                  .doc(UserKey.userKey)
                  .set({
                    "PhoneNumber": phoneNumber,
                  }, SetOptions(merge: true)) // <-- merge option goes here
                  .onError((e, _) => print("Error writing document: $e"));
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PersonalInfoSetting()),
              );
            })
            .catchError((error) {
              print("buddy Error ${error.code}");
              String errorMessage;
              switch (error.code) {
                case 'email-already-in-use':
                  errorMessage =
                      'อีเมลล์นี้ถูกใช้งานแล้ว';
                  break;
                case 'invalid-email':
                  errorMessage = 'รูปแบบอีเมลล์ไม่ถูกต้อง';
                  break;
                case "weak-password":
                  errorMessage =
                      'โปรดกรอกรหัสผ่านอย่างน้อย 6 ตัวอักษร';
                  break;
                case 'network-request-failed':
                  errorMessage =
                      'การเชื่อมต่อล้มเหลว';
                  break;
                default:
                  errorMessage = 'การลงทะเบียนล้มเหลว โปรดลองอีกครั้ง';

              }
                setState(() {
                  buttonChild = text;
                });
                Fluttertoast.showToast(
                  msg: errorMessage,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: MyColor.danger,
                  textColor: MyColor.white,
                  fontSize: 16.0,
                );
              
            });
      },

      child: Container(
        width: 150,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: MyColor.pinkPrimary,
          border: Border.all(color: MyColor.black, width: 1.0),
        ),
        child: Center(child: buttonChild),
      ),
    );
  }
}
