import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sic_app/custom/user_key.dart';

class IsStateEmergency {
  static bool isEmergency = false;

  static setEmergencyState({isEmergency}) {
    IsStateEmergency.isEmergency = isEmergency;
  }

  static setCloudEmergencyState({required void Function() onUpdate}) {
    final db = FirebaseFirestore.instance;
    db
        .collection("UserInfo")
        .doc(UserKey.userKey)
        .set({
          "EmergencyState": isEmergency,
        }, SetOptions(merge: true)) // <-- merge option goes here
        .onError((e, _) => print("Error writing document: $e"));
    onUpdate();
  }
}
