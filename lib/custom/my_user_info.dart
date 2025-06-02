class MyUserInfo {
  static String username = "";
  static String password = "";
  static String phoneNumber = '';
  static bool remember = false;

  static setUserInfo({username, password, phoneNumber, remember}) {
    MyUserInfo.username = username;
    MyUserInfo.password = password;
    MyUserInfo.phoneNumber = phoneNumber;
    MyUserInfo.remember = remember;
  }
}
