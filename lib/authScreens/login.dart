import 'package:avagaman/authScreens/admin.dart';
import 'package:avagaman/authScreens/committee.dart';
// import 'package:avagaman/authScreens/forgot_password.dart';
import 'package:avagaman/authScreens/security.dart';
import 'package:flutter/material.dart';

// import '../widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController id = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return const TabBarView(children: [
      SecurityPage(),
      CommitteePage(),
      AdminPage(),
    ]);
  }
}
