import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hairstylist_appointment/models/user_details_provider.dart';
import 'package:provider/provider.dart';
import './storage/users.dart';
import 'home.dart';
import 'social_sign_in.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final Users users = new Users();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void handleSignIn(
    String signInType,
    SocialSignIn socialSignIn,
    UserDetailsProvider userProvider,
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController,
  ) async {
    switch (signInType) {
      case "google":
        {
          UserCredential userCredential = await socialSignIn.signInWithGoogle();

          print("---- userCredential is ${userCredential.toString()}");

          if (userCredential.user != null) {
            print("---- user is ${userCredential.user}");
            userProvider.setUserInfo(
              userCredential.user!.email!,
              userCredential.user!.displayName!,
            );
            users.addUser(
              userCredential.user!.email!,
              userCredential.user!.displayName!,
            );
            Navigator.of(context).pushNamed(Home.routeName);
          }

          // Navigator.of(context).pushNamed(StylistOverview.routeName);
          print("sign in with google succeeded");
        }

        break;
      case "email":
        {
          try {
            UserCredential userCredential = await socialSignIn.signInWithEmail(
              emailController.text,
              passwordController.text,
            );
            print("--- userCredential is ${userCredential.user}");
            userProvider.setUserInfo(
              userCredential.user!.email!,
              userCredential.user!.displayName != null
                  ? userCredential.user!.displayName!
                  : "",
            );
            Navigator.of(context).pushNamed(Home.routeName);
          } on Exception catch (e) {
            print(e);
            print("--- email sign in failed");
          }
        }
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final userDetailsProvider = Provider.of<UserDetailsProvider>(context);
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
                onPressed: () {
                  handleSignIn(
                    "google",
                    socialSignIn,
                    userDetailsProvider,
                    context,
                    _emailController,
                    _passwordController,
                  );
                },
                child: Text(
                  "Login with Google",
                  style: GoogleFonts.roboto(fontSize: 16.0),
                ),
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
                          this.handleSignIn(
                            "email",
                            socialSignIn,
                            userDetailsProvider,
                            context,
                            _emailController,
                            _passwordController,
                          );
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
