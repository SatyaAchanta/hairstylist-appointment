import 'package:get/state_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserAuthController extends GetxController {
  var sample = 1.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  var userLoggedIn = (FirebaseAuth.instance.currentUser != null).obs;

  void isUserLoggedIn() {
    User? currentUser = auth.currentUser;
    userLoggedIn = (currentUser != null).obs;
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    if (userCredential.user == null) {
      // TODO: Use Snackbar to display login failed
      print("---- userCredential is $userCredential");
    }

    userLoggedIn = true.obs;

    return userCredential;
  }
}
