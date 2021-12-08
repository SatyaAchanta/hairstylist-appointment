import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/user_auth.dart';
import '../storage/userService.dart';
import '../about_stylist.dart';
import 'social_sign_in.dart';

class SignIn extends StatelessWidget {
  final UserService users = new UserService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  SocialSignIn signIn = new SocialSignIn();
  UserAuthController authController = Get.put(UserAuthController());

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    MediaQueryData mediaQuery = MediaQuery.of(context);
    Size deviceSize = mediaQuery.size;
    SocialSignIn socialSignIn = new SocialSignIn();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                left: deviceSize.width * 0.3,
                top: deviceSize.height * 0.1,
              ),
              child: Text(
                "Haircut Professionals",
                style: GoogleFonts.lato(
                  fontSize: 20.0,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: deviceSize.width * 0.2,
                left: deviceSize.height * 0.1,
              ),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  primary: Colors.black,
                ),
                child: Text(
                  "Login with Google",
                  style: GoogleFonts.roboto(fontSize: 16.0),
                ),
                onPressed: () {
                  authController.signInWithGoogle();
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: deviceSize.width * 0.05,
                vertical: deviceSize.height * 0.02,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter Email';
                        }
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(labelText: 'Password'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter Password';
                        }
                      },
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: deviceSize.width * 0.05,
                        left: deviceSize.height * 0.1,
                      ),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          primary: Colors.black,
                        ),
                        onPressed: () {
                          // this.handleSignIn(
                          //   "email",
                          //   socialSignIn,
                          //   userDetailsProvider,
                          //   context,
                          //   _emailController,
                          //   _passwordController,
                          // );
                        },
                        child: Text(
                          "Login With Email",
                          style: GoogleFonts.roboto(fontSize: 16.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
