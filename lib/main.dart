import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'sign_in.dart';
import 'services.dart';
import 'appointment_confirmation.dart';
import 'home.dart';
import 'models/appointment_details_provider.dart';
import 'models/user_details_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _initialized = false;
  bool _error = false;
  bool _isUserLoggedIn = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      setState(() {
        print("---- firebase initialized");
        _initialized = true;
      });
    } catch (e) {
      print("---- firebase initialization failed due to: ${e.toString()}");
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    print("---- inside initState");
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if (_error) {
      print("Firebase initialization failed in _error");
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      print("Firebase initialization failed in !_initialized");
    }

    if (_initialized) {
      print("Success....Firebase Initialized successfully");
    }

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        setState(() {
          this._isUserLoggedIn = false;
        });
      }
    });

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => AppointmentDetailsProvider()),
        ChangeNotifierProvider(create: (context) => UserDetailsProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: SignIn(),
        routes: {
          Services.routeName: (context) => Services(),
          Home.routeName: (context) => Home(),
          AppointmentConfirmation.routeName: (context) =>
              AppointmentConfirmation(),
        },
      ),
    );
  }
}
