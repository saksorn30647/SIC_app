class MyUserInfo {
  static String username = "";
  static String password = "";
  static String phoneNumber = '';
  static bool remember = false;

  static setUserInfo({username, password, phoneNumber}) {
    MyUserInfo.username = username;
    MyUserInfo.password = password;
    MyUserInfo.phoneNumber = phoneNumber;
  }
}
