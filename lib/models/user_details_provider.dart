import 'package:flutter/material.dart';
import 'user_details.dart';

class UserDetailsProvider extends ChangeNotifier {
  UserDetails user = new UserDetails();

  void setUserInfo(String email, String name) {
    user.email = email;
    user.name = name;
    notifyListeners();
  }

  UserDetails get userInfo {
    return user;
  }
}
