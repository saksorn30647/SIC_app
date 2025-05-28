import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:sic_app/custom/custom_color.dart';
import 'package:sic_app/doctor_main.dart';
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

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  // static const pickImageChannel = MethodChannel('myImageView'); 

  const MainApp({super.key});

  // static const backgroundColor = Color.fromARGB(255, 104, 231, 193);

  static const backgroundColor = LinearGradient(
    colors: [MyColor.white, MyColor.bluePrimary],
    stops: [0.08, 1.0],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: 
          LoginSceen(), 
          // LoginEnterForm(),
            // RegisterEnterForm(),  
              // PersonalInfoSetting(),
              // HealthInfoSetting(), 
            // UserMain(),
              // SettingScreen(),
              // ImagePickerScreen(),
            // DoctorMain(),
              // DoctorDanger(),
          // MyImageView(imageUrl: '',)
          //TOFO: Logo design
      theme: ThemeData(scaffoldBackgroundColor: MyColor.white),
    );
  }
}

