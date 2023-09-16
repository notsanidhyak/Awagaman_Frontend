import 'package:avagaman/authScreens/intro.dart';
import 'package:avagaman/authScreens/login.dart';
import 'package:avagaman/authScreens/verification.dart';
import 'package:avagaman/securityScreens/home.dart';
import 'package:dots_indicator/dots_indicator.dart';
// import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  final screens = [
    const IntroPage(),
    const LoginPage(),
    const OtpVerificationScreen()
  ];
  final buttonString = ["Get Started", "Get Login Code", "Verify"];
  // ignore: unused_field

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: index == 1
            ? AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: const Padding(
                  padding: EdgeInsets.only(top: 25.0),
                  child: TabBar(
                    automaticIndicatorColorAdjustment: false,
                    indicatorColor: Colors.transparent,
                    unselectedLabelColor: Colors.white30,
                    dividerColor: Colors.transparent,
                    labelColor: Colors.white70,
                    tabs: [
                      Tab(
                        text: "Security",
                      ),
                      Tab(
                        text: "Committee",
                      ),
                      Tab(
                        text: "Admin",
                      ),
                    ],
                  ),
                ),
              )
            : null,
        body: Stack(
          children: [
            screens[index],
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: MediaQuery.of(context).size.height * 0.25,
              child: Container(
                decoration: index != 0
                    ? const BoxDecoration(
                        color: Color(0xff121a25),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      )
                    : const BoxDecoration(color: Color(0xff121a25)),
                width: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    DotsIndicator(
                      dotsCount: 3,
                      position: index,
                      reversed: false,
                      mainAxisAlignment: MainAxisAlignment.center,
                      decorator: DotsDecorator(
                          activeSize: const Size(38.0, 9.0),
                          activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          activeColor: const Color(0xFFff725e),
                          color: Colors.grey),
                      onTap: (position) {
                        setState(() {
                          index = position.toInt();
                          // ++_activePage;
                        });
                      },
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (index < 2) {
                            index++;
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (c) => const SecurityHomePage()));
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFff725e),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 15,
                        ),
                      ),
                      child: Text(
                        buttonString[index],
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            )
            // Positioned(
            //   bottom: 0,
            //   left: 0,
            //   right: 0,
            //   height: 150,
            //   child: Container(
            //     color: Colors.black54,
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: List<Widget>.generate(
            //               screens.length,
            //               (index) => Padding(
            //                     padding:
            //                         const EdgeInsets.symmetric(horizontal: 10),
            //                     child: InkWell(
            //                       onTap: () {
            //                         _pageController.animateToPage(index,
            //                             duration:
            //                                 const Duration(milliseconds: 300),
            //                             curve: Curves.easeIn);
            //                       },
            //                       child: CircleAvatar(
            //                         radius: 8,
            //                         backgroundColor: _activePage == index
            //                             ? Colors.amber
            //                             : Colors.grey,
            //                       ),
            //                     ),
            //                   )),
            //         ),
            //         ElevatedButton(
            //           onPressed: () {
            //             _pageController.animateToPage(index,
            //                 duration: const Duration(milliseconds: 300),
            //                 curve: Curves.easeIn);
            //             setState(() {
            //               ++index;
            //               ++_activePage;
            //             });
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
            //             buttonString[index],
            //             style: GoogleFonts.poppins(
            //                 color: Colors.white,
            //                 fontSize: 18,
            //                 fontWeight: FontWeight.w600),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
