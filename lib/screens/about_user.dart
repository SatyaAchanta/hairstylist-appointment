import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUser extends StatefulWidget {
  const AboutUser({Key? key}) : super(key: key);

  @override
  _AboutUserState createState() => _AboutUserState();
}

class _AboutUserState extends State<AboutUser> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    Size deviceSize = mediaQuery.size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(
            vertical: deviceSize.height * 0.05,
            horizontal: deviceSize.width * 0.02,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Name';
                    }
                  },
                ),
                TextFormField(
                  controller: _ageController,
                  decoration: const InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Age';
                    }
                  },
                ),
                TextFormField(
                  controller: _genderController,
                  decoration: const InputDecoration(labelText: 'Gender'),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Gender';
                    }
                  },
                ),
                TextFormField(
                  controller: _phoneNumberController,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Phone Nmber';
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
                      if (_formKey.currentState!.validate()) {
                        // TODO: Save user here
                      } else {
                        const SnackBar(
                          content: Text("Please fill your information"),
                        );
                      }
                    },
                    child: Text(
                      "Confirm",
                      style: GoogleFonts.roboto(fontSize: 16.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
