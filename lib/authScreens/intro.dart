// import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 140),
        Center(
            child: Image.asset(
          "images/awagaman.png",
          width: MediaQuery.of(context).size.width * 0.6,
        )),
        const SizedBox(
          height: 95,
        ),
        Center(
            child: Image.asset(
          "images/building.png",
          width: MediaQuery.of(context).size.width * 0.7,
        )),
        // const SizedBox(
        //   height: 45,
        // ),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xff121a25),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 35),
                  child: Text(
                    "Easy In Easy Out",
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Empowering Hostel Dwellers with \n Effortless Entry and Exit Management',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(color: Colors.white54),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Expanded(
        //   child: Container(
        //     color: const Color(0xff121a25),
        //     width: double.infinity,
        //     child: Column(
        //       children: [
        //         DotsIndicator(
        //             dotsCount: 3,
        //             position: 0,
        //             reversed: false,
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             decorator: DotsDecorator(
        //                 activeSize: const Size(38.0, 9.0),
        //                 activeShape: RoundedRectangleBorder(
        //                     borderRadius: BorderRadius.circular(5.0)),
        //                 activeColor: const Color(0xFFff725e),
        //                 color: Colors.grey)),
        //         const SizedBox(height: 30),
        //         ElevatedButton(
        //           onPressed: () {
        //             // Navigator.push(
        //             //     context,
        //             //     MaterialPageRoute(
        //             //         builder: (c) => const SignUpScreen()));
        //           },
        //           style: ElevatedButton.styleFrom(
        //             backgroundColor: const Color(0xFFff725e),
        //             shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.circular(20),
        //             ),
        //             padding: const EdgeInsets.symmetric(
        //               horizontal: 50,
        //               vertical: 15,
        //             ),
        //           ),
        //           child: Text(
        //             'Get Started',
        //             style: GoogleFonts.poppins(
        //                 color: Colors.white,
        //                 fontSize: 18,
        //                 fontWeight: FontWeight.w600),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // )
      ],
    );
  }
}
