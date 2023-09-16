import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  OtpFieldController otpController = OtpFieldController();
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   backgroundColor: const Color(0xFF0a1119),
    //   body:
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 150),
          const Padding(
            padding: EdgeInsets.only(top: 70.0),
            child: Center(
              child: Text(
                "You're almost there!",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 15),
          const Center(
            child: Text("Enter the 6 digit OTP sent to your mobile number",
                style: TextStyle(fontSize: 15, color: Colors.grey)),
          ),
          const SizedBox(height: 50),
          Center(
            child: OTPTextField(
                controller: otpController,
                length: 5,
                width: MediaQuery.of(context).size.width,
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldWidth: 50,
                fieldStyle: FieldStyle.box,
                outlineBorderRadius: 15,
                otpFieldStyle: OtpFieldStyle(
                  backgroundColor: const Color.fromARGB(255, 30, 45, 65),
                  borderColor: Colors.white,
                  focusBorderColor: Colors.white,
                ),
                style: const TextStyle(fontSize: 17, color: Colors.grey),
                onChanged: (pin) {
                  // print("Changed: " + pin);
                },
                onCompleted: (pin) {
                  // print("Completed: " + pin);
                }),
          ),
          const SizedBox(height: 15),
          GestureDetector(
            child: const Padding(
              padding: EdgeInsets.only(left: 18.0),
              child: Text(
                "Resend OTP",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            onTap: () {},
          ),
          // ssSizedBox(height: MediaQuery.of(context).size.height * 0.25),
          // Container(
          //   height: MediaQuery.of(context).size.height * 0.30,
          //   decoration: const BoxDecoration(
          //       color: Color.fromARGB(255, 30, 45, 65),
          //       borderRadius: BorderRadius.all(Radius.circular(30))),
          //   child: Column(
          //     children: [
          //       const SizedBox(height: 30),
          //       const Row(
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [],
          //       ),
          //       DotsIndicator(
          //           dotsCount: 3,
          //           position: 2,
          //           reversed: false,
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           decorator: DotsDecorator(
          //               activeSize: const Size(38.0, 9.0),
          //               activeShape: RoundedRectangleBorder(
          //                   borderRadius: BorderRadius.circular(5.0)),
          //               activeColor: const Color(0xFF14b79a),
          //               color: Colors.grey)),
          //       const SizedBox(height: 30),
          //       ElevatedButton(
          //         onPressed: () {
          //           Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                   builder: (c) => SecurityHomePage()));
          //         },
          //         style: ElevatedButton.styleFrom(
          //           backgroundColor: const Color(0xFF14b79a),
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(20),
          //           ),
          //           padding: const EdgeInsets.symmetric(
          //             horizontal: 50,
          //             vertical: 15,
          //           ),
          //         ),
          //         child: const Text(
          //           'Verify',
          //           style: TextStyle(
          //             color: Colors.white,
          //             fontSize: 20,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // )
        ]);
  }
}
