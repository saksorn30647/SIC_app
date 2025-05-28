
class MyUserInfo {
  static String username = "";
  static String password = "";
  static String phoneNumber = '';

  static setUserInfo({username, password,phoneNumber}) {
    MyUserInfo.username = username;
    MyUserInfo.password = password;
    MyUserInfo.phoneNumber = phoneNumber;
  }
}

