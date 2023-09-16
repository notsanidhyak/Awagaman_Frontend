// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/custom_text_field.dart';

// ignore: must_be_immutable
class ForgotPassword extends StatefulWidget {
  ForgotPassword({
    Key? key,
  }) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

final User? user = FirebaseAuth.instance.currentUser;
final uid = user?.uid;

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _emailTextController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    // ignore: unnecessary_null_comparison
    if (_emailTextController == null) {
      Fluttertoast.showToast(msg: "Email cannot be empty");
    } else {
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: _emailTextController.text.trim());
        Fluttertoast.showToast(
            msg:
                "Reset password link has been sent to your email id : ${_emailTextController.text.trim()}");
      } on FirebaseAuthException {
        Fluttertoast.showToast(msg: "Invalid User");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text(
          "Forgot Password",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white70),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      backgroundColor: Colors.white70,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset("images/forgot_password.png"),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "Enter your registered email \n to reset your password",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextField(
                        textEditingController: _emailTextController,
                        iconData: Icons.email,
                        hintText: "Enter Registered Email Id",
                        isObscure: false,
                        enabled: true,
                        inputType: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueGrey,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 12)),
                          onPressed: () {
                            passwordReset();
                          },
                          child: const Text(
                            "Get the Link",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                      const SizedBox(
                        height: 110,
                      ),
                    ],
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
