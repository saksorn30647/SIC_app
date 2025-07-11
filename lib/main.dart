import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sic_app/bluetooth_discover.dart';

import 'package:sic_app/custom/custom_color.dart';
import 'package:sic_app/custom/my_user_info.dart';
import 'package:sic_app/custom/user_key.dart';
import 'package:sic_app/doctor_main.dart';
import 'package:sic_app/face_scan_tutorial.dart';
import 'package:sic_app/image_picker_screen.dart';
import 'package:sic_app/login_enter_form.dart';
import 'package:sic_app/my_image_view.dart';
import 'package:sic_app/others/firebase_options.dart';
import 'package:sic_app/health_info_setting.dart';
import 'package:sic_app/login_screen.dart';
import 'package:sic_app/personal_info_setting.dart';
import 'package:sic_app/register_enter_form.dart';
import 'package:sic_app/setting_screen.dart';
import 'package:sic_app/user_main.dart';

// import 'package:sic_app/user_main.dart';

Future<void> main() async {
  // runApp(MainApp(isLoggedIn: false));
  // return;

  WidgetsFlutterBinding.ensureInitialized();
  // print('Before Firebase init');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('After Firebase init');

  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

  // FirebaseAuth.instance.authStateChanges().listen((User? user) {
  //   if (user != null) {
  //     print(user.uid);
  //   }
  // });
  final prefs = await SharedPreferences.getInstance();
  final isRemember = prefs.getBool("remember");
  bool isSignedIn = false;
  if (isRemember != null && isRemember) {
    final username = prefs.getString("username");
    final password = prefs.getString("password");
    final remember = prefs.getBool("remember");

    if (username != null && password != null) {
      // Set user info in custom class
      MyUserInfo.setUserInfo(
        username: username,
        password: password,
        phoneNumber: "",
      );
      MyUserInfo.remember = remember ?? false;
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: MyUserInfo.username,
          password: MyUserInfo.password,
        );
        isSignedIn = FirebaseAuth.instance.currentUser != null;
        print("is signed in: $isSignedIn");
        if (isSignedIn) {
          UserKey.setUserKey(
            userkey: MyUserInfo.username,
          );
        }
      } on FirebaseAuthException catch (e) {
        print("Error signing in: ${e.message}");
        isSignedIn = false;
      }
    }
  } else {
    MyUserInfo.setUserInfo(
      username: '',
      password: '',
      phoneNumber: '',
    );
    MyUserInfo.remember = false;
  }

  print(MyUserInfo.username);
  print(MyUserInfo.password);
  print(MyUserInfo.phoneNumber);
  print(MyUserInfo.remember);

  try {} catch (e) {
    print("Error setting system UI overlay style: $e");
  }

  runApp(MainApp(isLoggedIn: isSignedIn));
}

class MainApp extends StatelessWidget {
  // static const pickImageChannel = MethodChannel('myImageView');
  final bool isLoggedIn;

  const MainApp({super.key, this.isLoggedIn = false});

  // static const backgroundColor = Color.fromARGB(255, 104, 231, 193);

  static const backgroundColor = LinearGradient(
    colors: [MyColor.white, MyColor.bluePrimary],
    stops: [0.08, 1.0],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: FaceScanTutorialScreen(),
      // home: BluetoothDiscoverScreen(),
      // home: UserMain(),

      home:
          isLoggedIn
              ? UserMain()
              : LoginScreen(), 

      // LoginEnterForm(),
      // RegisterEnterForm(),
      // PersonalInfoSetting(),
      // HealthInfoSetting(),
      // LoginScreen(), 
      // UserMain(),
      // SettingScreen(),
      // ImagePickerScreen(),
      // DoctorMain(),
      // DoctorDanger(),
      // MyImageView(imageUrl: '',)
      // TODO: wrap main, login screen with single child scroll view
      theme: ThemeData(scaffoldBackgroundColor: MyColor.white),
    );
  }
}
