import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import './authentication/sign_in.dart';
import 'screens/stylist/stylist.dart';
import './controller/user_auth.dart';
import 'about_stylist.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Main2());
}

class Main2 extends StatelessWidget {
  const Main2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserAuthController authController = Get.put(UserAuthController());
    return GetMaterialApp(
      home: authController.userLoggedIn.isTrue ? Stylist() : SignIn(),
      theme: ThemeData(
        primaryColor: Colors.purple,
      ),
      routes: {
        '/stylistSample': (context) => Stylist(),
        '/stylist': (context) => AboutStylist(),
      },
    );
  }
}
