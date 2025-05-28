import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sic_app/custom/custom_color.dart';
import 'package:sic_app/custom/emergency_state.dart';
import 'package:sic_app/my_image_view.dart';
import 'package:sic_app/user_main.dart';

// Image picker service from earlier
class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    return image != null ? File(image.path) : null;
  }
}

// Main widget
class ImagePickerScreen extends StatefulWidget {
  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  static const pickImageChannel = MethodChannel('pickImagePlatform');
  final ImagePickerService _pickerService = ImagePickerService();
  File? _selectedImage;
  String _imagePath = "";

  void _getImageFromCamera() async {
    try {
      final String image = await pickImageChannel.invokeMethod('pickImage');
      // print("Image path: $image");
      setState(() {
        _imagePath = image;
        print("_Image path: $_imagePath");
      });
    } catch (e) {
      print("Buddy Error: $e");
    }
  }

  @override
  void initState() {
    super.initState();

    onPredictResult();
  }

  static const MethodChannel predictResultChannel = MethodChannel(
    'aicanseeyourstroke.com/predictResultPlatform',
  );
  double? result;
  double threshold = 0.5;
  void onPredictResult() {
    predictResultChannel.setMethodCallHandler((MethodCall call) async {
      print("Buddy Flutter Method called: ${call.method}");
      try {
        if (call.method == 'predictResult') {
          final double result = call.arguments;
          print("Buddy Flutter Predict Result: $result");
          setState(() {
            this.result = result;
            if (result > threshold) {
              IsStateEmergency.setEmergencyState(isEmergency: true);
              IsStateEmergency.setCloudEmergencyState(
                onUpdate: () {
                  print("Emergency state updated to true");
                },
              );
            } else {
              IsStateEmergency.setEmergencyState(isEmergency: false);
              IsStateEmergency.setCloudEmergencyState(
                onUpdate: () {
                  print("Emergency state updated to false");
                },
              );
            }
          });
        } else {
          print("Budder Flutter Unknown method called: ${call.method}");
        }
      } catch (e) {
        print("Buddy Flutter Error: $e");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors:
                IsStateEmergency.isEmergency
                    ? [MyColor.gray, MyColor.gray, MyColor.black]
                    : [
                      MyColor.white,
                      MyColor.blueSecondary,
                      MyColor.bluePrimary,
                    ],
            stops: [0.0, 0.7, 1.0],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 14,
            left: 18,
            right: 18,
            bottom: 18,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextPhoto(result: result),
                SizedBox(height: 30),
                // if (_selectedImage != null)
                if (_imagePath != "")
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: MyColor.black,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      // child: Image.file(_selectedImage!),
                      child: MyImageView(imageUrl: _imagePath),
                    ),
                  )
                else
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: MyColor.white,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                SizedBox(height: 30),
                CameraButton(getImageFromCamera: _getImageFromCamera),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextPhoto extends StatelessWidget {
  final num? result;

  const TextPhoto({super.key, this.result});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [MyColor.pinkPrimary, MyColor.white],
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          stops: [0, 1.0],
        ),
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              result == null ? "กรุณายิ้มและถ่ายรูปหน้าตรง" : result.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            SizedBox(width: 10),
            SvgPicture.asset('assets/smile.svg', width: 24, height: 24),
          ],
        ),
      ),
    );
  }
}

class CameraButton extends StatelessWidget {
  final void Function() getImageFromCamera;

  const CameraButton({super.key, required this.getImageFromCamera});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // try {
        //   final String image = await pickImageChannel.invokeMethod('pickImage');
        //   print("Image path: $image");
        // }catch (e) {
        //   print("Buddy Error: $e");
        // }
        getImageFromCamera();
      },
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: MyColor.white,
          border: Border.all(color: MyColor.black, width: 1.0),
        ),
        child: Center(
          child: SvgPicture.asset('assets/camera.svg', width: 70, height: 70),
        ),
      ),
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
              retypePasswordController: retypePasswordController,
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
          MaterialPageRoute(builder: (context) => UserMain()),
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
  final TextEditingController retypePasswordController;

  const AcceptButton({
    super.key,
    required this.usernameController,
    required this.passwordController,
    required this.retypePasswordController,
  });

  @override
  State<AcceptButton> createState() => _AcceptButtonState();
}

class _AcceptButtonState extends State<AcceptButton> {
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        setState(() {
          username = widget.usernameController.text;
          password = widget.passwordController.text;
        });
        print('Username: $username');
        print('Password: $password');

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => UserMain()),
        // );
      },

      child: Container(
        width: 150,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color:
              IsStateEmergency.isEmergency
                  ? MyColor.danger
                  : MyColor.pinkPrimary,
          border: Border.all(color: MyColor.black, width: 1.0),
        ),
        child: Center(
          child: Text(
            IsStateEmergency.isEmergency ? "โทร 1669" : "ยืนยัน",
            style: TextStyle(
              fontSize: 20,
              color: IsStateEmergency.isEmergency ? MyColor.white : MyColor.black,
            ),
          ),
        ),
      ),
    );
  }
}
