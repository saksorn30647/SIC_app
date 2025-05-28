import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:sic_app/custom/user_key.dart';
import 'package:sic_app/setting_screen.dart';

class PersonalInfo {
  static String name = '';
  static String surname = '';
  static String nickname = '';
  static String year = '2568';
  static String month = 'ม.ค.';
  static String date = '1';
  static String weight = '';
  static String height = '';
  static String id = '';
  static String emergencyContact = '';
  static String gender = 'ชาย';
  static String bloodGroup = 'A';

  static setPersonalInfo({
    name,
    surname,
    nickname,
    weight,
    height,
    id,
    emergencyContact,
  }) {
    PersonalInfo.name = name;
    PersonalInfo.surname = surname;
    PersonalInfo.nickname = nickname;
    PersonalInfo.weight = weight;
    PersonalInfo.height = height;
    PersonalInfo.id = id;
    PersonalInfo.emergencyContact = emergencyContact;
  }

  static getPersonalInfo() {
    return {
      'name': name,
      'surname': surname,
      'nickname': nickname,
      'weight': weight,
      'height': height,
      'id': id,
      'emergencyContact': emergencyContact,
      'year': year,
      'month': month,
      'date': date,
      'gender': gender,
      'bloodgroup': bloodGroup,
    };
  }

  static cloudPersonalInfoGetter({required void Function() onUpdate}) {

    final db = FirebaseFirestore.instance;
    final docRef = db.collection("UserInfo").doc(UserKey.userKey);

    print("${UserKey.userKey} PersonalInfo");

    try {
      docRef.get().then((DocumentSnapshot doc) {
        final myData = doc.data() as Map<String, dynamic>;
        final personalInfoData = myData['PersonalInfo'] as Map<String, dynamic>;

        print(personalInfoData);
        PersonalInfo.setPersonalInfo(
          name: personalInfoData['name'] ?? '',
          surname: personalInfoData['surname'] ?? '',
          nickname: personalInfoData['nickname'] ?? '',
          weight: personalInfoData['weight'] ?? '',
          height: personalInfoData['height'] ?? '',
          id: personalInfoData['id'] ?? '',
          emergencyContact: personalInfoData['emergencyContact'] ?? '',
        );
        PersonalInfo.year = personalInfoData['year'] ?? '2568';
        PersonalInfo.month = personalInfoData['month'] ?? 'ม.ค.';
        PersonalInfo.date = personalInfoData['date'] ?? '1';
        onUpdate();
      }, onError: (e) => print("Error getting document: $e"));
    } catch (e) {
      print("Error getting document: $e");
    }
    
  }
}

// FirebaseFirestore.instance
//   .collection('UserInfo')
//   .doc(UserKey.userKey)
//   .get()
//   .then((DocumentSnapshot doc) {
//     final data = doc.data() as Map<String, dynamic>;
//     final personal = data['PersonalInfo'] as Map<String, dynamic>;

//     print('Name: ${personal['name']}');
//     print('Nickname: ${personal['nickname']}');
//   });