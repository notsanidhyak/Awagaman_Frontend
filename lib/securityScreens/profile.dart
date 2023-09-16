import 'package:avagaman/securityScreens/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SecurityProfile extends StatefulWidget {
  const SecurityProfile({super.key});

  @override
  State<SecurityProfile> createState() => _SecurityProfileState();
}

class _SecurityProfileState extends State<SecurityProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 60,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Text(
                  "Profile",
                  style: GoogleFonts.poppins(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 25.0),
                child: IconButton(
                    iconSize: 30,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => const SecurityHomePage()));
                    },
                    icon: const Icon(
                      Icons.arrow_circle_left_outlined,
                      color: Colors.white70,
                    )),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Card(
            elevation: 10,
            color: const Color(0xff121a25),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.17,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Name - Block E Gate",
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Colors.white38),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "ID- IIITV/Hostel101",
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Colors.white38),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Approved by - Pramit Mazumadar",
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Colors.white38),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff121a25),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 15,
                    ),
                  ),
                  child: Text(
                    "Logout",
                    style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: Colors.white38),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
