import 'package:avagaman/authScreens/forgot_password.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_text_field.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({super.key});

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController id = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AppBar(
          //   bottom: TabBar(
          //     tabs: [
          //       Tab(
          //         text: "lly",
          //       ),
          //       Tab(
          //         text: "snfsd",
          //       )
          //     ],
          //   ),
          // ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 28.0),
            child: Text(
              "ID",
              style: TextStyle(color: Colors.grey, fontSize: 18),
              textAlign: TextAlign.justify,
            ),
          ),
          CustomTextField(
            textEditingController: id,
            iconData: Icons.person,
            hintText: "Enter your 5 digit Login Id",
            // labelText: "Name is one ",
            isObscure: false,
            enabled: true,
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(left: 28.0),
            child: Text(
              "Password",
              style: TextStyle(color: Colors.grey, fontSize: 18),
              textAlign: TextAlign.justify,
            ),
          ),
          CustomTextField(
            textEditingController: password,
            iconData: Icons.person,
            hintText: "Enter your password",
            // labelText: "Name is one ",
            isObscure: false,
            enabled: true,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 30.0),
            child: GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ForgotPassword())),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "Reset Password",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  // Icon(
                  //   Icons.arrow_forward,
                  //   color: Colors.blueAccent,
                  // )
                  // )),
                  //                 "Forgot password?"
                  //                     .text
                  //                     .underline
                  //                     .lg
                  //                     .color(context.theme.accentColor)
                  //                     .make())
                ],
              ),
            ),
          ),
          // SizedBox(
          //   height: MediaQuery.of(context).size.height * 0.20,
          // )
        ],
      ),
    );
  }
}
