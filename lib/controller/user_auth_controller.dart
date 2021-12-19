import 'package:get/state_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user_details.dart';

class UserAuthController extends GetxController {
  final user = UserDetails().obs;
  var sample = 1.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  var userLoggedIn = (FirebaseAuth.instance.currentUser != null).obs;

  UserAuthController() {
    if (userLoggedIn.isTrue) {
      print("--- user is already logged in");
      user.update((val) {
        val!.email = auth.currentUser!.email;
        val.name = auth.currentUser!.displayName;
      });
    }
  }

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

    user.update((val) {
      val!.email = userCredential.user!.email;
      val.name = userCredential.user!.displayName;
    });

    return userCredential;
  }

  Future<UserCredential> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      throw e;
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
