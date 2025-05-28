import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sic_app/custom/user_key.dart';

class HealthInfo {
  static String sysBloodPressure = '';
  static String diaBloodPressure = '';

  static String chronicDisease1 = '';
  static String chronicDisease2 = '';
  static String chronicDisease3 = '';

  static String medicineHistory1 = '';
  static String medicineHistory2 = '';
  static String medicineHistory3 = '';

  static String medicineAllergic1 = '';
  static String medicineAllergic2 = '';
  static String medicineAllergic3 = '';

  static String medicalRecord1 = '';
  static String medicalRecord2 = '';
  static String medicalRecord3 = '';

  static String riskFactor1 = '';
  static String riskFactor2 = '';
  static String riskFactor3 = '';

  static setHealthInfo({
    sysBloodPressure,
    diaBloodPressure,
    chronicDisease1,
    chronicDisease2,
    chronicDisease3,
    medicineHistory1,
    medicineHistory2,
    medicineHistory3,
    medicineAllergic1,
    medicineAllergic2,
    medicineAllergic3,
    medicalRecord1,
    medicalRecord2,
    medicalRecord3,
    riskFactor1,
    riskFactor2,
    riskFactor3,
  }) {
    HealthInfo.sysBloodPressure = sysBloodPressure;
    HealthInfo.diaBloodPressure = diaBloodPressure;
    HealthInfo.chronicDisease1 = chronicDisease1;
    HealthInfo.chronicDisease2 = chronicDisease2;
    HealthInfo.chronicDisease3 = chronicDisease3;
    HealthInfo.medicineHistory1 = medicineHistory1;
    HealthInfo.medicineHistory2 = medicineHistory2;
    HealthInfo.medicineHistory3 = medicineHistory3;
    HealthInfo.medicineAllergic1 = medicineAllergic1;
    HealthInfo.medicineAllergic2 = medicineAllergic2;
    HealthInfo.medicineAllergic3 = medicineAllergic3;
    HealthInfo.medicalRecord1 = medicalRecord1;
    HealthInfo.medicalRecord2 = medicalRecord2;
    HealthInfo.medicalRecord3 = medicalRecord3;
    HealthInfo.riskFactor1 = riskFactor1;
    HealthInfo.riskFactor2 = riskFactor2;
    HealthInfo.riskFactor3 = riskFactor3;
  }

  static getHealthInfo() {
    return {
      'sysBloodPressure': sysBloodPressure,
      'diaBloodPressure': diaBloodPressure,
      'chronicDisease1': chronicDisease1,
      'chronicDisease2': chronicDisease2,
      'chronicDisease3': chronicDisease3,
      'medicineHistory1': medicineHistory1,
      'medicineHistory2': medicineHistory2,
      'medicineHistory3': medicineHistory3,
      'medicineAllergic1': medicineAllergic1,
      'medicineAllergic2': medicineAllergic2,
      'medicineAllergic3': medicineAllergic3,
      'medicalRecord1': medicalRecord1,
      'medicalRecord2': medicalRecord2,
      'medicalRecord3': medicalRecord3,
      'riskFactor1': riskFactor1,
      'riskFactor2': riskFactor2,
      'riskFactor3': riskFactor3,
    };
  }

  static cloudHealthInfoGetter({required void Function() onUpdate}) {
    final db = FirebaseFirestore.instance;
    final docRef = db.collection("UserInfo").doc(UserKey.userKey);

    print("${UserKey.userKey} HealthInfo");

    try {
      docRef.get().then((DocumentSnapshot doc) {
        final myData = doc.data() as Map<String, dynamic>;
        final healthInfoData = myData['HealthInfo'] as Map<String, dynamic>;

        print(healthInfoData);
        HealthInfo.setHealthInfo(
          sysBloodPressure: healthInfoData['sysBloodPressure'] ?? '',
          diaBloodPressure: healthInfoData['diaBloodPressure'] ?? '',
          chronicDisease1: healthInfoData['chronicDisease1'] ?? '',
          chronicDisease2: healthInfoData['chronicDisease2'] ?? '',
          chronicDisease3: healthInfoData['chronicDisease3'] ?? '',
          medicineHistory1: healthInfoData['medicineHistory1'] ?? '',
          medicineHistory2: healthInfoData['medicineHistory2'] ?? '',
          medicineHistory3: healthInfoData['medicineHistory3'] ?? '',
          medicineAllergic1: healthInfoData['medicineAllergic1'] ?? '',
          medicineAllergic2: healthInfoData['medicineAllergic2'] ?? '',
          medicineAllergic3: healthInfoData['medicineAllergic3'] ?? '',
          medicalRecord1: healthInfoData['medicalRecord1'] ?? '',
          medicalRecord2: healthInfoData['medicalRecord2'] ?? '',
          medicalRecord3: healthInfoData['medicalRecord3'] ?? '',
          riskFactor1: healthInfoData['riskFactor1'] ?? '-',
          riskFactor2: healthInfoData['riskFactor2'] ?? '-',
          riskFactor3: healthInfoData['riskFactor3'] ?? '-',
        );

        onUpdate();
      }, onError: (e) => print("Error getting document: $e"));
    } catch (e) {
      print("Error getting document: $e");
    }
  }
}
